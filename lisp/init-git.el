(lqz/require '(magit gitignore-mode git-timemachine git-gutter))


;; disable magit startup messages
(setq magit-last-seen-setup-instructions "1.4.0")

;; magit shortcut key
(global-set-key (kbd "C-c g s") 'magit-status)


;; git-gutter
;; If you would like to use git-gutter.el and linum-mode
(git-gutter:linum-setup)

;; enable git-gutter-mode for some modes
(add-hook 'prog-mode-hook 'git-gutter-mode)
(add-hook 'fish-mode-hook 'git-gutter-mode)
(add-hook 'vimrc-mode-hook 'git-gutter-mode)

;; update interval seconds
(custom-set-variables
 '(git-gutter:update-interval 1)
 '(git-gutter:modified-sign "m")
 '(git-gutter:added-sign "+")
 '(git-gutter:deleted-sign "-"))

;; background
(set-face-background 'git-gutter:modified "#383838")
(set-face-foreground 'git-gutter:added "#383838")
(set-face-foreground 'git-gutter:deleted  "#383838")

;; keybings
(global-set-key (kbd "C-x C-g") 'git-gutter:toggle)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)
(global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x n") 'git-gutter:next-hunk)
(global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)



(provide 'init-git)
