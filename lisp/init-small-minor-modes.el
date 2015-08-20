;;----------------------------------------------------------------------------
;; simple minor modes
;;----------------------------------------------------------------------------
(derive-from-prog-mode
 (my/install '(vimrc-mode
               fish-mode
               yaml-mode
               lua-mode
               dockerfile-mode
               nginx-mode)))

(add-auto-mode 'vimrc-mode "\\.vim\\(rc\\)?\\'")
(add-auto-mode 'fish-mode "\\.fish\\(rc\\)?\\'")
(add-auto-mode 'nginx-mode "nginx.*")



(provide 'init-small-minor-modes)
