(defgroup x-clipboard nil
  "X-clipboard."
  :prefix "x-clipboard"
  :group 'tools)

(defcustom x-clipboard-show-message t
  "Whether show messages after clipboard actions."
  :group 'x-clipboard
  :type 'boolean)

(defcustom x-clipboard-abort-region-after-copy t
  "Whether abort region selection after content is copied."
  :group 'x-clipboard
  :type 'boolean)

(defcustom x-clipboard-write-programs
  '(("xclip" "-selection" "clipboard" "-i")
    ("xsel" "-b" "-i"))
  "Available programs(and corresponding arguments)used for
  setting or getting x clipboard content. They should read
  content from stdin, and then push it to system clipboard."
  :group 'x-clipboard
  :type 'sexp)

(defcustom x-clipboard-read-programs
  '(("xclip" "-selection" "clipboard" "-o")
    ("xsel" "-b" "-o"))
  "Available programs(and corresponding arguments) used for
  getting or getting x clipboard content."
  :group 'x-clipboard
  :type 'sexp)

(defcustom x-clipboard-default-text-obj 'line
  "Default text object to operate when no region selected.
Possible values: `word', `line', `line-end', `symbol', `sentence', `paragraph'."
  :group 'x-clipboard :type
  '(choice (const :tag "Paragraph" paragraph)
           (const :tag "Line" line)
           (const :tag "Word" word)
           (const :tag "Symbol" symbol)
           (const :tag "Sentence" sentence)))

(defun x-clipboard--get-thing-bounds (type)
  (case type
    ((word line symbol sentence)
     (let ((bounds (bounds-of-thing-at-point type)))
       (list (car bounds) (cdr bounds))))
    (line-end
     (list (point) (line-end-position)))
    (paragraph
     (save-excursion
       (start-of-paragraph-text)
       (let ((start (point)))
         (end-of-paragraph-text)
         (list start (point)))))))

(defun x-clipboard--find-program (programs)
  "Pick an available program from `x-clipboard-programs'."
  (catch 'program
    (mapc
     (lambda (it)
       (when (executable-find (car it))
         (throw 'program it)))
     programs)
    nil))

;;;###autoload
(defun xcopy-text (content)
  (if (display-graphic-p)
      (gui-set-selection 'CLIPBOARD content)
    (let ((program (x-clipboard--find-program x-clipboard-write-programs)))
      (unless program
        (error "Failed to find an available program to set clipboard."))
      (with-temp-buffer
        (insert content)
        (eval
         `(call-process-region
           (point-min) (point-max)
           ,(car program) nil nil nil ,@(cdr program)))))))

;;;###autoload
(defun xcopy (&optional start end)
  "Copy content between START and END to system clipboard.
If a region is active, use it. Or use content pointed by
`x-clipboard-default-text-obj'."
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (x-clipboard--get-thing-bounds x-clipboard-default-text-obj)))
  (xcopy-text (buffer-substring-no-properties start end))
  (when x-clipboard-show-message
    (message "Copied to clipboard."))
  (when (and x-clipboard-abort-region-after-copy
             (use-region-p))
    (deactivate-mark)))

;;;###autoload
(defun xpaste (&optional no-insert)
  "Paste system clipboard's contents into current point."
  (interactive "P")
  (let (str)
    (if (display-graphic-p)
        (setq str (gui-get-selection 'CLIPBOARD 'TEXT))
      (let ((program (x-clipboard--find-program x-clipboard-read-programs)))
        (unless program
          (error "Failed to find an available program to access clipboard."))
        (with-temp-buffer
          (eval `(call-process ,(car program) nil t nil ,@(cdr program)))
          (setq str (buffer-substring (point-min) (point-max))))))
    (save-excursion
      (unless (or no-insert (null str))
        (when (use-region-p)
          (delete-region (region-beginning) (region-end)))
        (insert str)))
    str))

;;;###autoload
(defun xcut (&optional start end)
  "Cut content between START and END to system clipboard."
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (x-clipboard--get-thing-bounds x-clipboard-default-text-obj)))
  (let (x-clipboard-show-message)
    (xcopy start end)
    (delete-region start end))
  (when x-clipboard-show-message
    (message "Cut to clipboard.")))



(provide 'x-clipboard)
