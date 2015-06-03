(defun region-text ()
  (buffer-substring (region-beginning region-end)))

(defun xsel-copy (&optional del)
  "Copy or cut the active region (from BEG to END) to the system clipboard."
  (interactive)
  (unless (use-region-p)
    (error "No region to copy"))
  (let ((pos (list (region-beginning) (region-end))) (act "copied"))
    (print pos)
    (call-process-region (car pos) (cadr pos) "xsel" nil 0 nil "--clipboard" "--input")
    (if del (and (setf act "cut") (delete-region (car pos) (cadr pos))))
  (message "%s to clipboard" act)))

(defun xsel-paste ()
  "Paste system clipboard's contents into buffer."
  (interactive)
  (if (use-region-p)
      (delete-region (region-beginning) (region-end)))
  (insert (shell-command-to-string "xsel --clipboard --output"))
  (message "pasted from clipboard"))

(defun xsel-cut () (interactive) (xsel-copy t))



(provide 'init-clipboard)
