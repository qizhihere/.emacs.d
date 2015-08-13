;;;###autoload
(defun xcopy (&optional del)
  "Copy or cut region to the system clipboard."
  (interactive)
  (unless (use-region-p)
	(error "No region to copy"))
  (let ((content (buffer-substring-no-properties (region-beginning) (region-end))))
	(cond
	 ((display-graphic-p)
	  (x-set-selection 'CLIPBOARD content))
	 ((executable-find "xclip")
	  (with-temp-buffer
		(insert content)
		(call-process-region (point-min) (point-max) "xclip" nil nil nil "-selection" "clipboard" "-i")))
	 ((executable-find "xsel")
	  (call-process-region (car pos) (cadr pos) "xsel" nil nil nil "-b" "-i"))
	 (t (error "Niether xclip nor xclip installed!"))))
  (when del (delete-region (region-beginning) (region-end)))
  (message "%s to clipboard." (if del "Cut" "Copied")))

;;;###autoload
(defun xpaste ()
  "Paste system clipboard's contents into buffer."
  (interactive)
  (let ((content
		 (cond ((display-graphic-p)
				(x-get-selection 'CLIPBOARD))
			   ((executable-find "xsel")
				(call-process "xsel" nil t nil "-b" "-o"))
			   ((executable-find "xclip")
				(call-process "xclip" nil t nil "-selection" "clipboard" "-o")))))
	(if (use-region-p)
		(delete-region (region-beginning) (region-end)))
	(insert content)))

;;;###autoload
(defun xcut ()
  "Cut region text to system clipboard."
  (interactive) (xcopy t))



(provide 'system-clipboard)
