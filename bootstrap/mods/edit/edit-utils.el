(defun first-char-or-beginning-of-line ()
  "Move point to the first non-empty char or the beginning of
current line."
  (interactive)
  (if (looking-back "^\\s-*" nil)
      (beginning-of-line)
    (back-to-indentation)))

(defun join-next-line ()
  "Join contents in current line and next line."
  (interactive)
  (join-line -1))

(defun open-next-line ()
  "Open a new line below."
  (interactive)
  (save-excursion
    (newline)))

(defun open-previous-line ()
  "Open a new line above."
  (interactive)
  (let ((pos (point))
        (max (point-max)))
    (beginning-of-line)
    (newline)
    (goto-char (+ pos (- (point-max) max)))))

(defun backward-symbol (arg)
  "Move cursor backward a WORD. With argument, move many times."
  (interactive "p")
  (forward-symbol (- (or arg 1))))

(defun yank-line-no-eol ()
  (interactive)
  (kill-ring-save (line-beginning-position) (line-end-position)))

(defun query-replace-from-region-or-symbol (&optional from to)
  "Query replace from current region or symbol."
  (interactive)
  (save-excursion
    (let* ((from (or from (current-region-or-word)))
           (to (or to (read-from-minibuffer
                       (format "Replace 「%s」 to: " from)))))
      (if (use-region-p)
          (progn
            (goto-char (region-beginning))
            (deactivate-mark t))
        (backward-symbol 1))
      (query-replace from to))))

(defun kill-line--just-one-space (&rest args)
  "Merge multiple whitespaces into one when kill line."
  (if (and (eolp) (not (bolp)))
      (progn (forward-char 1)
             (just-one-space 1)
             (backward-char 2))))

(defun describe-function-at-point (&optional pos)
  "Describe function at current(or given) position."
  (interactive)
  (unless (integerp pos)
    (setq pos (point)))
  (let* ((pos (bounds-of-thing-at-point 'symbol))
         (word (if pos (intern (buffer-substring-no-properties (car pos) (cdr pos))))))
    (when pos
      (if (fboundp word)
          (describe-function word)
        (call-interactively #'describe-function)))))

(defun describe-variable-at-point (&optional pos)
  "Describe variable at current(or given) position."
  (interactive)
  (unless (integerp pos)
    (setq pos (point)))
  (let* ((pos (bounds-of-thing-at-point 'symbol))
         (word (if pos (intern (buffer-substring-no-properties (car pos) (cdr pos))))))
    (when pos
      (if (boundp word)
          (describe-variable word)
        (call-interactively #'describe-variable)))))
