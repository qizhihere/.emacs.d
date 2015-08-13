(my/require '(2048-game edit-server))

;; edit server (use emacs as browser text editor)
(when (require 'edit-server nil t)
  (setq edit-server-new-frame t
	edit-server-default-major-mode 'markdown-mode)
  (add-hook 'edit-server-edit-mode-hook 'delete-other-windows)
  (add-hook 'edit-server-edit-mode-hook 'delete-other-windows)
  (edit-server-start))

(setq edit-server-url-major-mode-alist
      '(("github\\.com" . markdown-mode)))



(provide 'init-fun)
