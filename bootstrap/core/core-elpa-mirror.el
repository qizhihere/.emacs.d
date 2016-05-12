(require 'package)

(defvar elpa-mirror-directory (concat user-emacs-directory "elpa-mirror")
  "The default elpa mirror output directory.")
(defvar elpa-mirror-archive `("elpa-mirror" . ,elpa-mirror-directory)
  "Archive which operated by `enable-elpa-mirror' and `disable-elpa-mirror'.")

(defvar elpa-mirror-timer nil)
(defvar elpa-mirror--running-p nil)
(defvar elpa-mirror-timepoints '("9:00" "14:00" "20:30"))

(defvar elpa-mirror-utils-path load-file-name)
(defvar elpa-mirror-lib-url "https://raw.githubusercontent.com/redguardtoo/elpa-mirror/master/elpa-mirror.el")
(defvar async-lib-url "https://raw.githubusercontent.com/jwiegley/emacs-async/master/async.el")

(defun enable-elpa-mirror (&optional refresh)
  (interactive)
  (if (and elpa-mirror-directory
           (file-directory-p elpa-mirror-directory))
      (progn
        (add-to-list 'package-archives elpa-mirror-archive)
        (when refresh (package-refresh-contents)))
    (error "`elpa-mirror-directory' is not set.")))

(defun disable-elpa-mirror (&optional refresh)
  (interactive)
  (setq package-archives (delete elpa-mirror-archive))
  (when refresh (package-refresh-contents)))

(defun elpa-mirror--require-self ()
  (unless (require 'elpa-mirror nil t)
    (with-temp-buffer
      (url-insert-file-contents elpa-mirror-lib-url)
      (eval-buffer))))

(defun elpa-mirror--require-async ()
  (unless (require 'async nil t)
    (with-temp-buffer
      (url-insert-file-contents async-lib-url)
      (eval-buffer))))

(defun elpa-mirror--do-mirror ()
  (elpa-mirror--require-self)
  (unless package--initialized
    (package-initialize))
  (setq elpa-mirror--running-p t)
  (unwind-protect
      (elpamr-create-mirror-for-installed)
    (setq elpa-mirror--running-p nil)))

(defun mirror-elpa (&optional sync)
  (interactive "P")
  (when elpa-mirror--running-p
    (error "A async mirroring task is already running."))
  ;; ensure output directory exists
  (setq elpamr-default-output-directory
        (or elpa-mirror-directory
            (read-directory-name "Output directory: ")))
  (mkdir elpamr-default-output-directory t)
  ;; start mirroring
  (if sync
      (elpa-mirror--do-mirror)
    (elpa-mirror--require-async)
    (message "Asynchronously mirroring elpa...")
    (setq elpa-mirror--running-p t)
    (async-start
     `(lambda ()
        (load ,elpa-mirror-utils-path nil t)
        (setq elpamr-default-output-directory
              ,elpamr-default-output-directory)
        (let ((load-file-name ,elpa-mirror-utils-path))
          (elpa-mirror--do-mirror)))
     (lambda (res)
       (message "ELPA mirror: %s" res)
       (setq elpa-mirror--running-p nil)))))

(defun elpa-mirror--check-timepoints ()
  (when (and (member (format-time-string "%H:%M")
                     elpa-mirror-timepoints)
             (not elpa-mirror--running-p))
    (mirror-elpa)))

(defun turn-on-elpa-mirror-timer ()
  (interactive)
  (turn-off-elpa-mirror-timer)
  (if (timerp elpa-mirror-timer)
      (timer-activate elpa-mirror-timer)
    (setq elpa-mirror-timer
          (run-with-timer 0 60 #'elpa-mirror--check-timepoints))))

(defun turn-off-elpa-mirror-timer ()
  (interactive)
  (when (timerp elpa-mirror-timer)
    (cancel-timer elpa-mirror-timer)))



(provide 'core-elpa-mirror)
