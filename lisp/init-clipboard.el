;; disable automatically copy selected region to x clipboard
(setq x-select-enable-clipboard nil)
(setq xcopy-prefer-gui t
      xpaste-prefer-gui nil)

(defun xcopy (&optional del)
  "Copy or cut the active region (from BEG to END) to the system
clipboard."
  (interactive)
  (unless (use-region-p)
    (error "No region to copy"))
  (let ((pos (list (region-beginning) (region-end)))
	(act "Copied")
	(cmd (if (executable-find "xclip") '("xclip" "-selection clipboard -i") '("xsel" "-bi"))))
    (if (and (display-graphic-p) (boundp 'xcopy-prefer-gui) xcopy-prefer-gui)
	(x-set-selection 'CLIPBOARD (buffer-substring (car pos) (cadr pos)))
      (cond ((executable-find "xclip")
	     (call-process-region (car pos) (cadr pos) "xclip" nil 0 nil "-selection" "clipboard" "-i"))
	    ((executable-find "xsel")
	     (call-process-region (car pos) (cadr pos) "xsel" nil 0 nil "-b" "-i"))
	    (t (error "Niether xclip nor xclip installed!"))))
    (if del (and (setq act "Cut") (delete-region (car pos) (cadr pos))))
    (message "%s to clipboard." act)))

(defun xpaste ()
  "Paste system clipboard's contents into buffer."
  (interactive)
  (let ((content ""))
    (if (and (display-graphic-p) (boundp 'xpaste-prefer-gui) xpaste-prefer-gui)
	(setq content (x-get-clipboard))
      (let* ((cmd
	      (if (executable-find "xclip")
		  "xclip -selection clipboard -o"
		"xsel -bo")))
	(setq content (shell-command-to-string cmd))))
    (if (use-region-p)
	(delete-region (region-beginning) (region-end)))
    (insert content)))


(defun xcut ()
  "Cut region text to system clipboard."
  (interactive) (xcopy t))



(provide 'init-clipboard)
