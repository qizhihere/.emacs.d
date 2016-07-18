(require 'cl)

(defun concat-sym (&rest args)
  "Concatenate all symbols to one."
  (intern (reduce #'concat (mapcar #'symbol-name args))))


(defmacro silently (&rest body)
  "Execute BODY silently."
  (declare (indent defun))
  `(let ((inhibit-message t)
         message-log-max)
     ,@body))


(defmacro loaded (file &rest body)
  "Execute BODY after FILE is loaded."
  (declare (indent defun))
  (if (symbolp file)
      `(with-eval-after-load ',file
         ,@body)
    `(with-eval-after-load ,file
       ,@body)))
(put 'loaded 'lisp-indent-function 'defun)


(defmacro echo (string)
  "Echo STRING with message logging disabled."
  (declare (indent defun))
  `(let (message-log-max)
     (message "%s" ,string)))


(defun thing-at-point--region-advice (orig-func thing &optional no-properties)
  "Make `thing-at-point' support region thing. If no action
region then symbol is used."
  (if (eq thing 'region)
      (if (use-region-p)
          (if no-properties
              (buffer-substring-no-properties (region-beginning) (region-end))
            (buffer-substring (region-beginning) (region-end)))
        (funcall orig-func 'symbol no-properties))
    (funcall orig-func thing no-properties)))
(advice-add 'thing-at-point :around #'thing-at-point--region-advice)


(defun current-region-or-word ()
  (interactive)
  (if (use-region-p)
      (let ((beg (region-beginning))
            (end (region-end)))
        (if (eq beg end)
            (current-word)
          (buffer-substring-no-properties beg end)))
    (current-word)))


(defmacro merge-to (old new)
  "Merge NEW list into OLD list. Duplicates are removed."
  (declare (indent defun))
  (let ((val (if (boundp old) (symbol-value old) nil)))
    `(set ',old (remove-duplicates (append ',val ,new) :test #'equal))))


(defun nested-list-p (object)
  "Test if a OBJECT is a nested list."
  (and (listp object)
       (loop for x in object
             thereis (listp x))))


(defun add-hooks (&rest args)
  "Add a bunch of hooks.
    (add-hooks '(A B C D) '(E F))
    (add-hooks '(A B)  'E)
    (add-hooks '(A . B) '(C . (E F)) '((G H I) . (J K)))"
  (cl-flet* ((to-list (x) (if (listp x) x (list x)))
             (add-it (hook func)
                     (let ((hook (to-list hook))
                           (func (to-list func)))
                       (dolist (x hook)
                         (dolist (y func)
                           (add-hook x y)))))
             (pred (x) (or (not (listp x))
                           (and (listp x)
                                (not (nested-list-p x))
                                (listp (cdr x))))))
    (let ((e0 (car args))
          (e1 (cadr args)))
      (if (and (= (length args) 2)
               (pred e0) (pred e1))
          (add-it e0 e1)
        (dolist (pair args)
          (add-it (car pair) (cdr pair)))))))


(defun derived-mode-ancestors (mode)
  "Get all ancestors of derived MODE. Includes those defined by
`defalias'."
  (when (and mode (fboundp mode))
    (let ((func (symbol-function mode))
          (parent (get mode 'derived-mode-parent)))
      (if (symbolp func)
          ;; fix mode defined by defalias
          (append (list func)
                  (derived-mode-ancestors func))
        (when parent
          (append (list parent)
                  (derived-mode-ancestors parent)))))))

(defun real-derived-mode-p (mode)
  "Test if `major-mode' is derived from MODE. This function
simply get its ancestors by `derived-mode-ancestors', and test if
MODE is included."
  (find mode (append (list major-mode)
                     (derived-mode-ancestors major-mode))))

(defun active-minor-modes ()
  "Get current active minor modes."
  (loop for x in minor-mode-list
        when (and (boundp x) (symbol-value x))
        collect x))

(defun active-modes ()
  "Get current active modes. Both `major-mode' and minor modes
  are included."
  (remq nil (remove-duplicates (append (list major-mode)
                                       (active-minor-modes)))))

(defun find-active-modes (modes)
  "Find active modes in MODES. A parent or ancestor mode in MODES
will also be tested."
  (let (set)
    (dolist (major-mode (active-modes))
      (dolist (x modes)
        (when (real-derived-mode-p x)
          (push x set))))
    set))


(defun in-modes-p (modes)
  "Test if any mode in MODES is active now."
  (not (null (find-active-modes modes))))


(defun theme-obsoleted-faces (theme)
  "Get obsoleted faces of THEME."
  (when theme
    (loop for s in (get theme 'theme-settings)
          for face = (cadr s)
          when (and (eq (car s) 'theme-face)
                    (get face 'obsolete-face))
          collect face)))


(defun lock-face (face)
  "Lock a face to prevent it being modified. FACE maybe a symbol
or a list of symbols."
  (if (listp face)
      (dolist (x face)
        (lock-face x))
    (put face 'face-locked t)))

(defun locked-face-checker (orig-func &rest args)
  "Advice used by `lock-face'."
  (unless (and (car args) (get (car args) 'face-locked))
    (apply orig-func args)))
(advice-add 'face-spec-set :around #'locked-face-checker)


(defun dos2unix ()
  "Convert `\\r\\n' to `\\n'."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "\r" nil t)
      (replace-match ""))))

(defun find-recursively(path &rest switches)
  "Find file recursively in `PATH'."
  (unless (executable-find "find")
    (error "No executable file `find' found in $PATH."))
  (apply 'process-lines
         (append (list "find" (expand-file-name path)) switches)))


(defun delete-this-buffer-and-file ()
  "Delete the current file, and kill the buffer."
  (interactive)
  (or (buffer-file-name) (error "No file is currently being edited"))
  (when (yes-or-no-p (format "Really delete '%s'?"
                             (file-name-nondirectory buffer-file-name)))
    (unwind-protect
        (ignore-errors (delete-file (buffer-file-name)))
      (kill-buffer))))


(defun rename-this-file-and-buffer (&optional new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive)
  (let* ((name (buffer-name))
         (filename (buffer-file-name))
         (new-name (or new-name (read-string "New name: " name))))
    (if (get-buffer new-name)
        (message "A buffer named '%s' already exists!" new-name)
      (progn
        (when (and filename (file-exists-p filename))
          (rename-file filename new-name 1))
        (rename-buffer new-name)
        (set-visited-file-name new-name)))))


(defun send-keys (keys)
  "Send keystrokes to Emacs."
  (execute-kbd-macro (read-kbd-macro keys)))


;; by Christopher Wellons, 2011-11-18. Editted by Xah Lee.  Edited
;; by Hideki Saito further to generate all valid variants for "N" in
;; xxxxxxxx-xxxx-Mxxx-Nxxx-xxxxxxxxxxxx format.
(defun random-uuid ()
  "Insert a UUID."
  (interactive)
  (let ((myStr (md5 (format "%s%s%s%s%s%s%s%s%s%s"
                            (user-uid)
                            (emacs-pid)
                            (system-name)
                            (user-full-name)
                            (current-time)
                            (emacs-uptime)
                            (garbage-collect)
                            (buffer-string)
                            (random)
                            (recent-keys)))))
    (format "%s-%s-4%s-%s%s-%s"
            (substring myStr 0 8)
            (substring myStr 8 12)
            (substring myStr 13 16)
            (format "%x" (+ 8 (random 4)))
            (substring myStr 17 20)
            (substring myStr 20 32))))


(defvar process-dedicated-buffers-exclude '("^*\\[.*\\]*$")
  "Buffer name regexps which will not be set dedicated to process.")
(defun process-make-buffer-dedicated (&optional buffer)
  "Make a BUFFER dedicated to its process. When the process is
finished or exited the BUFFER will be killed. Note that the
window of the buffer will be deleted as well."
  (let* ((buffer (or buffer (current-buffer)))
         (process (get-buffer-process buffer)))
    (when (and (processp process)
               (not (find (buffer-name buffer)
                          process-dedicated-buffers-exclude
                          :test (lambda (x s) (string-match-p s x)))))
      (set-process-sentinel
       process
       (lambda (proc change)
         (when (string-match "\\(finished\\|exited\\)" change)
           (let* ((buf (process-buffer proc))
                  (win (get-buffer-window buf)))
             (when win (set-window-dedicated-p win t))
             (when (buffer-live-p buf) (kill-buffer buf)))))))
    buffer))

(defun comint-clear-buffer ()
  "Clear the content of current comint buffer."
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (save-excursion
      (goto-char (point-max))
      (comint-truncate-buffer))))


(defmacro define-repl (repl &optional no-max-func docstring &rest body)
  "Define a REPL. If NO-MAX-FUNC is not set, then the maximized
version function named REPL-maximized will also be defined. BODY
is a list of sexp, it should return either a interpreter process
or a buffer which contains the interpreter process."
  (declare (doc-string 3))
  (let* ((repl-max (intern (format "%s-maximized" repl)))
         (docstring (if (stringp docstring)
                        docstring
                      (setq body (cons docstring body))
                      nil))
         (func `(defun ,repl (&optional maximized)
                  ,docstring
                  (interactive "P")
                  (let* ((res (progn ,@body))
                         (buf (if (bufferp res) res (process-buffer res))))
                    (if maximized
                        (progn
                          (switch-to-buffer buf)
                          (delete-other-windows))
                      (pop-to-buffer buf))))))
    (if no-max-func
        func
      `(progn
         ,func
         (defun ,repl-max ()
           ,(when docstring
              (format "%s This is the maximized version." docstring))
           (interactive)
           (,repl t))))))

(defun term-run (program &optional name maximized &rest switches)
  "Run command in a new term."
  (require 'term)
  (let* ((name (or name program))
         (buf (format "*%s*" name)))
    (set-buffer (apply #'term-ansi-make-term `(,buf ,program nil ,@(remq nil switches))))
    (term-mode)
    (term-char-mode)
    (let (term-escape-char)
      (term-set-escape-char ?\C-x))
    (if maximized
        (switch-to-buffer buf)
      (pop-to-buffer buf))))


(defun indent-buffer ()
  "Indent current buffer with `indent-region-function'."
  (interactive)
  (indent-region (point-min) (point-max)))
