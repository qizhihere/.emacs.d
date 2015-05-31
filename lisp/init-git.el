(lqz/require '(magit gitignore-mode git-timemachine))


;; disable magit startup messages
(setq magit-last-seen-setup-instructions "1.4.0")

;; magit shortcut key
(global-set-key (kbd "C-c g s") 'magit-status)



(provide 'init-git)
