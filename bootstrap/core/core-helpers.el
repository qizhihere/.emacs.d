;; This file define some commonly used function helpers
(require 'cl)
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

(defun m|add-path (path &optional append)
  "Add `PATH' to `$PATH' environment variable."
  (let ((PATH (getenv "PATH")))
    (unless (member path (split-string PATH ":"))
      (setenv "PATH" (if append (concat PATH ":" path)
                       (concat path ":" PATH))))
    (add-to-list 'exec-path path append)))

(defmacro m|load-conf (file mod)
  (declare (indent defun))
  (let* ((var (intern (format "m|%s-conf-dir" mod)))
         (file (expand-file-name file (symbol-value var))))
    `(load ,file nil t)))

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

(cl-defun m|unbind-key
    (key &optional (keymap global-map)
         &key if)
  (if (listp key)
      (dolist (k key)
        (m|unbind-key k keymap :if if))
    (let ((binding (lookup-key keymap (kbd key)))
          result)
      (when (or (null if)
                (and if (funcall if binding)))
        (define-key keymap (kbd key) nil)))))

(defmacro m|evil-leader (&rest bindings)
  (declare (indent defun))
  `(loaded evil-leader
     ,@bindings))

(defmacro __dir__ (&optional relative-path)
  (let ((dir (file-name-directory
              (or load-file-name (expand-file-name ".")))))
    (if relative-path
        (expand-file-name relative-path dir)
      dir)))



(provide 'core-helpers)
