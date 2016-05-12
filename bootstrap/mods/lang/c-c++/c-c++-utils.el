(defvar compile-output-directory "bin")
(make-variable-buffer-local 'compile-output-directory)

(defvar compile-run-compiler-alist
  '((c++-mode . ("g++" "-std=c++11"))
    (c-mode . ("gcc")))
  "Compiler list used by `compile-and-run'.")

(defun compile--prepare-output-directory ()
  (let ((dir (compile--output-directory)))
    ;; maybe need create output directory
    (or (file-exists-p dir) (mkdir dir t))))

(defun compile--output-directory ()
  (or compile-output-directory "."))

(defun compile--output-filename ()
  (let ((binary (file-name-sans-extension (buffer-name)))
        (dir (compile--output-directory)))
    (if (string-prefix-p "/" dir)
        (expand-file-name binary dir)
      (file-relative-name (expand-file-name binary dir) "."))))

(defun compile-current-file ()
  "Compile current file."
  (interactive)
  (let* ((item (assoc major-mode compile-run-compiler-alist))
         compiler args)
    (unless item
      (error "Failed to find a suitable compiler. Please check
      `compile-run-compiler-alist'."))
    ;; maybe need create output directory
    (compile--prepare-output-directory)
    ;; set compile arguments
    (setq compiler (cadr item)
          args (eval `(concat ,@(cddr item))))
    ;; start compile
    (compile (format "%s %s '%s' -o '%s'" compiler args
                     (file-name-nondirectory (buffer-file-name))
                     (compile--output-filename)))))

(defun run-current-compiled (&optional set-flags)
  "Run compiled binary of current file. When called with a
prefix, prompts for flags to run the executable."
  (interactive "P")
  (let ((bin (compile--output-filename)))
    (cond
     ((not (file-exists-p bin))
      (signal 'file-error
              (format "Binary `%s' not found. Maybe need recompile?" bin)))
     ((not (file-executable-p bin))
      (signal 'file-error (format "File `%s' is not executable." bin)))
     (t (let* ((flags (when set-flags
                        (string-remove-prefix bin (read-string "Run: " bin))))
               (buf (term-run
                     bin (format "[%s]" bin) nil flags))
               (proc (get-buffer-process buf)))
          (when (processp proc)
            (set-process-sentinel
             proc
             (lambda (pr ch)
               (when (string-match-p "\\(finished\\|exited\\)" ch)
                 (with-current-buffer (process-buffer pr)
                   (view-mode 1)))))))))))

(defun clean-current-compiled (&optional no-message)
  "Clean compiled binary of current file."
  (interactive "P")
  (let ((file (compile--output-filename)))
    (if (file-exists-p file)
        (progn
          (delete-file file)
          (unless no-message
            (message "Compiled file `%s' removed." file)))
      (unless no-message
        (message "This file haven't been compiled.")))))

(defun compile-and-run-current-file (&optional set-flags)
  "Compile and run current file automatically. The compiler is
picked from `compile-run-compiler-alist'. If SET-ARGV is t,
prompts for flags to run the executable."
  (interactive "P")
  (let ((proc (get-buffer-process (compile-current-file)))
        (out (compile--output-filename)))
    (when (processp proc)
      (let ((sentinel (process-sentinel proc))
            (callback `(lambda (proc change)
                         (when (string-match "finished" change)
                           (let ((win (get-buffer-window (process-buffer proc))))
                             (when (window-live-p win)
                               (delete-window win)))
                           (with-current-buffer ,(buffer-name)
                             (run-current-compiled ,set-flags))))))
        (when sentinel
          (when (symbolp sentinel)
            (setq sentinel (symbol-function sentinel)))
          (add-function :after callback sentinel))
        (set-process-sentinel proc callback)))))
