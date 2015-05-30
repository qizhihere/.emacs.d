(lqz/require '(bm helm-bm))
(autoload 'bm-toggle   "bm" "Toggle bookmark in current buffer." t)
(autoload 'bm-next     "bm" "Goto bookmark."                     t)
(autoload 'bm-previous "bm" "Goto previous bookmark."            t)

;; bookmark keys
(global-set-key (kbd "C-c b l") 'helm-bm)
(global-set-key (kbd "C-c b m") 'bm-toggle)



(provide 'init-bookmark)
