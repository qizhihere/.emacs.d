(defun my/install (package)
  (if (listp package)
	  (dolist (x package)
		(my/install x))
	(when (not package-archive-contents)
	  (package-refresh-contents))
	(when (not (package-installed-p package))
	  (package-install package))))

(defun my/require (package)
  (if (listp package)
	  (dolist (x package)
		(my/require x))
	(my/install package) (require package)))

(defun my/try-install (package)
  (condition-case err
	  (my/install package)
	(error
	 (message "Couldn't install package `%s': %S" package err))))

(if (fboundp 'with-eval-after-load)
	(defalias 'after-load 'with-eval-after-load)
  (defmacro after-load (package &rest body)
	(declare (indent defun))
	`(eval-after-load ,package
	   '(progn ,@body))))

(my/require 'dash)
(after-load 'dash (dash-enable-font-lock))


(defmacro with-installed (package &rest body)
  (declare (indent defun))
  `(progn
	 (let ((package ,package))
	   (if (not (listp package))
		   (setq package (list package)))
	   (if (--all? (package-installed-p it) package)
		   (progn ,@body)))))


(defvar my/after-init-hooks '())

(defmacro after-init (&rest body)
  (declare (indent defun))
  `(setq my/after-init-hooks
		 (append my/after-init-hooks '(,@body))))

(defun my/run-init-hooks ()
  (dolist (x my/after-init-hooks)
	(eval x)))

(add-hook 'after-init-hook 'my/run-init-hooks)

(defun derived-from-prog-mode (mode)
  "Make mode derived from `prog-mode'."
  (put mode 'derived-mode-parent 'prog-mode))

(require 'cl)
(defmacro silently-do (&rest body)
  "Do commands silently with `message' doing nothing."
  `(flet ((message (&rest args) nil))
	 ,@body))

(defun silently-load (orig-func &rest ARGS)
  "Disable message displaying at startup when loading files."
  (if (and (boundp '*startup-silently*)
		   *startup-silently*)
	  (silently-do (apply orig-func ARGS))
	(apply orig-func ARGS)))

(advice-add 'load :around #'silently-load)
;; (after-init (advice-remove 'load #'silently-load))

(defun show-startup-time ()
  (cond ((and (boundp '*start-at-time*) (boundp '*start-restore-at*))
		 (message "Emacs loaded in %.2fs, desktop restored in %.2fs."
				  (- *start-finished-at-time* *start-at-time*)
				  (- *start-finished-at-time* *start-restore-at*)))
		((boundp '*start-at-time*)
		 (message "Emacs loaded in %.2fs." (- *start-finished-at-time* *start-at-time*)))
		((boundp '*start-restore-at*)
		 (message "Desktop restored in %.2fs." (- *start-finished-at-time* *start-restore-at*)))))

(defadvice display-startup-echo-area-message (around my/startup-message activate)
  (when (not (boundp '*start-finished-at-time*))
	(setq *start-finished-at-time* (float-time)))
  (when (not (boundp 'show-startup-time-timer))
	(setq show-startup-time-timer
		  (run-at-time "1 seconds" nil #'show-startup-time))))

(defun add-auto-mode (mode &rest patterns)
  "Add entries to `auto-mode-alist' to use `MODE' for all given file `PATTERNS'."
  (dolist (pattern patterns)
	(add-to-list 'auto-mode-alist (cons pattern mode))))

(defun delete-this-file ()
  "Delete the current file, and kill the buffer."
  (interactive)
  (or (buffer-file-name) (error "No file is currently being edited"))
  (when (yes-or-no-p (format "Really delete '%s'?"
							 (file-name-nondirectory buffer-file-name)))
	(delete-file (buffer-file-name))
	(kill-this-buffer)))

(defun rename-this-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
		(filename (buffer-file-name)))
	(unless filename
	  (error "Buffer '%s' is not visiting a file!" name))
	(if (get-buffer new-name)
		(message "A buffer named '%s' already exists!" new-name)
	  (progn
		(when (file-exists-p filename)
		  (rename-file filename new-name 1))
		(rename-buffer new-name)
		(set-visited-file-name new-name)))))

(defun my/system-notify (title &optional msg timeout)
  "Use external program to send a system notification."
  (let* ((timeout (if timeout (concat " -t " timeout)))
		 (cmd (concat "notify-send" " -i Emacs" timeout " '" title "' '" msg "'")))
	(start-process-shell-command
	 "*Output*" nil
	 (replace-regexp-in-string "&" "&amp;" cmd))))

(defun my/select-file (msg &optional dir)
  (let ((file (file-relative-name
			   (read-file-name msg
							   (if (and dir (file-exists-p dir))
								   dir
								 (if (and (boundp 'my/last-dir) (file-exists-p my/last-dir))
									 my/last-dir
								   default-directory))))))
	(setq my/last-dir (file-name-directory (file-truename file)))
	file))

(defun my/send-keys (keys)
  (execute-kbd-macro (read-kbd-macro keys)))

(defun cat (filepath)
  "Return filepath's file content."
  (if (file-exists-p filepath)
	  (with-temp-buffer
		(insert-file-contents filepath)
		(buffer-string)) ""))

(defun my/current-word ()
  (interactive)
  (if (use-region-p)
	  (let ((bounds (list (region-beginning) (region-end))))
		(buffer-substring-no-properties (car bounds) (car (cdr bounds))))
	(current-word)))


(provide 'init-utils)
