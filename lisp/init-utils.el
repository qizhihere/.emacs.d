;; some common used functions

(defun lqz/iter-eval (target cmd)
  "apply cmd to target or every element in list target."
  (if (listp target)
    (dolist (x target) (eval cmd))
    (let ((x target)) (eval cmd))))

(defun lqz/mkdir (dir)
  "check directories and create them if not exists."
  )

(defun lqz/mkrdir (dir)
  "create subdirectories relative to ~/.emacs.d"
  (lqz/iter-eval dir
    '(if (not (file-exists-p x))
    (make-directory (lqz/init-dir x) t))))

(defun lqz/load-file (path)
  "load file according to its relative path to init.el"
  (load-file (lqz/init-dir path)))

(defun add-more-to-list (target source)
  "append source list to target list."
  (dolist (x source) (add-to-list target x)))

(defun lqz/require (package)
  (lqz/iter-eval package
    '(let ((x (if (stringp x) (intern x) x)))
    (if (not (package-installed-p x))
        (package-install x))
    (require x))))



(provide 'init-utils)
