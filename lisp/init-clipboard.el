(defun region-text ()
  (buffer-substring (region-beginning region-end)))

(defun xsel-copy ()
  "Copy the active region (from BEG to END) to the system clipboard."
  (interactive)
  (unless (use-region-p)
    (error "No region to copy"))
  (call-process-region (region-beginning) (region-end) "xsel" nil 0 nil "--clipboard" "--input")
  (message "copied to clipboard"))

(defun xsel-paste ()
  (interactive)
  (if (use-region-p)
      (delete-region (region-beginning) (region-end)))
  (insert (shell-command-to-string "xsel --clipboard --output"))
  (message "pasted from clipboard"))



(provide 'init-clipboard)
