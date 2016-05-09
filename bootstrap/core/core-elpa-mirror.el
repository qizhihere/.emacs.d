(require 'package)

(defvar elpa-mirror-directory (concat user-emacs-directory "elpa-mirror"))
(defvar elpa-mirror-archive `("elpa-mirror" . ,elpa-mirror-directory))

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
  (elpamr-create-mirror-for-installed))

(defun mirror-elpa (&optional async)
  (interactive "P")
  (unless (bound-and-true-p elpamr-default-output-directory)
    (setq elpamr-default-output-directory
          (read-directory-name "Output directory: ")))
  (mkdir elpamr-default-output-directory t)
  (if async
      (progn
        (elpa-mirror--require-async)
        (async-start
         `(lambda ()
            (load ,elpa-mirror-utils-path nil t)
            (setq elpamr-default-output-directory
                  ,elpamr-default-output-directory)
            (let ((load-file-name ,elpa-mirror-utils-path))
              (elpa-mirror--do-mirror)))
         (lambda (res) (message "ELPA mirror: %s" res))))
    (elpa-mirror--do-mirror)))



(provide 'core-elpa-mirror)
