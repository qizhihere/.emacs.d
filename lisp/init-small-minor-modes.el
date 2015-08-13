;;----------------------------------------------------------------------------
;; simple minor modes
;;----------------------------------------------------------------------------
(my/install '(yaml-mode
			  lua-mode
			  dockerfile-mode))

;; vimrc mode
(my/install 'vimrc-mode)
(add-auto-mode 'vimrc-mode "\\.vim\\(rc\\)?\\'")

;; fish mode
(my/install 'fish-mode)
(add-auto-mode 'fish-mode "\\.fish\\(rc\\)?\\'")

;; nginx mode
(my/install 'nginx-mode)
(add-auto-mode 'nginx-mode "nginx.*")



(provide 'init-small-minor-modes)
