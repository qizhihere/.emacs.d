;; This file define some commonly used function helpers
(require 'core-vars)

(defun m|home (&optional subdir)
  "Get the absolute path of a sub-directory in `m|home'."
  (expand-file-name (or subdir "") user-emacs-directory))

(defun m|conf (&optional subdir)
  "Get the absolute sub-directory path relative to `m|conf'."
  (expand-file-name (or subdir "") m|conf))

(defun m|cache-dir (&optional subdir)
  "Get the absolute path of a sub-directory in `m|conf'."
  (expand-file-name (or subdir "") m|cache-dir))

(defun m|add-path (path &optional prepend)
  "Add `PATH' to `$PATH' environment variable."
  (let ((PATH (getenv "PATH")))
    (unless (member path (split-string PATH ":"))
      (setenv "PATH" (if prepend (concat path ":" PATH)
                       (concat PATH ":" path))))))

(defun m|load-relative (file &optional ref)
  (let* ((dir (file-name-directory
               (or ref load-file-name (expand-file-name "."))))
         (file (expand-file-name file dir)))
    (load file nil t)))

(defun m|maybe-install-packages (&optional packages)
  (dolist (pkg (or packages m|pkgs))
    (unless (package-installed-p pkg)
      (if (symbolp pkg)
          (progn
            (when (and (fboundp 'async-bytecomp-package-mode)
                       (not (bound-and-true-p async-bytecomp-package-mode)))
              (async-bytecomp-package-mode 1))
            (condition-case nil
                (package-install pkg)
              (file-error (progn
                            (message "A file error occurred. Refreshing package list...")
                            (sit-for 1)
                            (package-refresh-contents)
                            (package-install pkg)))))
        (quelpa pkg)))))

(defmacro loaded (file &rest body)
  "Execute BODY after FILE is loaded."
  (when (symbolp file)
    (setq file (symbol-name file)))
  `(with-eval-after-load ,file
     ,@body))
(put 'loaded 'lisp-indent-function 'defun)

(defun m|keep-point-advice (orig-func &rest args)
  (save-excursion (apply orig-func args)))

(defun m|fullscreen-post-advice (&rest args)
  (delete-other-windows))

(defun m|silent-advice (orig-func &rest args)
  (let ((inhibit-message t)
        message-log-max)
    (apply orig-func args)))

(defmacro m|be-quiet (&rest funcs)
  `(mapc
    (lambda (sym)
      (advice-add sym :around #'m|silent-advice))
    '(,@funcs)))



(provide 'core-helpers)
