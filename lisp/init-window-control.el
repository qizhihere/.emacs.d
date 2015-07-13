(lqz/require '(window-numbering perspective))

;; fix unknown bug
(window-numbering-mode -1)
(window-numbering-mode t)

;; perspective(for workspace)
(persp-mode)

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

;; shortcut key for other window move
(global-set-key (kbd "C-M-v")	'other-window-move-down)
(global-set-key (kbd "C-M-b")	'other-window-move-up)

(defun window-numbering-get-number-string (&optional window)
  (let ((s (concat " [" (concat (int-to-string (window-numbering-get-number window)) "]"))))
    (propertize s 'face 'window-numbering-face)))



(provide 'init-window-control)
