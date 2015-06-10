(lqz/require '(magit gitignore-mode git-timemachine git-gutter))


;; disable magit startup messages
(setq magit-last-seen-setup-instructions "1.4.0")

;; magit shortcut key
(global-set-key (kbd "C-c g s") 'magit-status)

;; git-gutter
(add-hook 'prog-mode-hook 'git-gutter-mode)
(add-hook 'fish-mode-hook 'git-gutter-mode)
(add-hook 'vimrc-mode-hook 'git-gutter-mode)



(provide 'init-git)
