(my/require '(window-numbering persp-mode))

(defun other-window-move-down(&optional arg)
  "Other window move-down 2 lines."
  (interactive "p")
  (scroll-other-window 2))

(defun other-window-move-up(&optional arg)
  "Other window move-down 2 lines."
  (interactive "P")
  (if arg
	  (scroll-other-window-down arg)
	(scroll-other-window-down 2)))

(defun window-numbering-get-number-string (&optional window)
  (let ((s (concat " [" (concat (int-to-string (window-numbering-get-number window)) "] "))))
	(propertize s 'face 'window-numbering-face)))

(defun my/persp-cycle (&optional num)
  "Cycling `persp' workspaces.

If `num' is negative, then switch to previous workspace, else the
next one.
  "
  (interactive)
  (let* ((neg? (and num (< num 0)))
	 (cur (safe-persp-name (get-frame-persp)))
	 (persps (persp-names-sorted))
	 (pos (cl-position cur persps :test #'string=))
	 (trail (if neg? 0 (1- (length persps))))
	 (cycle (if neg? (1- (length persps)) 0))
	 (target (if neg? (1- pos) (1+ pos))))
	(cond
	 ((null pos) (persp-switch))
	((= pos trail)
	 (persp-switch (nth cycle persps)))
	(t (persp-switch (nth target persps))))))

(defun my/persp-next ()
  "Switch to the next persp workspace."
  (interactive)
  (my/persp-cycle))

(defun my/persp-prev ()
  "Switch to the previous persp workspace."
  (interactive)
  (my/persp-cycle -1))

(customize-set-variable 'persp-nil-name "main")
(after-load "persp-mode-autoloads"
  (after-load "persp-mode-autoloads"
	(setq wg-morph-on nil ;; switch off animation
		  persp-save-dir (my/init-dir "session/"))
	(after-init (persp-mode 1))))

;; shortcut key for other window move
(global-set-key (kbd "C-M-v")	'other-window-move-down)
(global-set-key (kbd "C-M-b")	'other-window-move-up)

;; fix unknown bug
;; (window-numbering-mode -1)
(window-numbering-mode t)

;; set persp keys(`s` means super)
(global-set-key (kbd "M-\\")	'persp-switch)
(global-set-key (kbd "M-[")	'my/persp-prev)
(global-set-key (kbd "M-]")	'my/persp-next)



(provide 'init-workspace)
