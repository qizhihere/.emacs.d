(setq cvs-packages '(diff-hl))

(defun cvs/init ()
  )

(defun cvs/init-diff-hl ()
  (use-package diff-hl
    :defer t
    :init
    (m|add-startup-hook #'global-diff-hl-mode)
    (when window-system (m|add-startup-hook #'diff-hl-flydiff-mode))
    (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
    (add-hook 'dired-mode-hook 'diff-hl-dired-mode)))
