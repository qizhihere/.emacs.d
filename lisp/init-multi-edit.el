(lqz/require '(multiple-cursors iedit))

;; multiple cursors
(global-set-key (kbd "C-c m e")	'mc/edit-lines)
(global-set-key (kbd "M-{")	'mc/mark-previous-like-this)
(global-set-key (kbd "M-}")	'mc/mark-next-like-this)
(global-set-key (kbd "C-c m a")	'mc/mark-all-like-this)

(global-unset-key (kbd "C-M-<down-mouse-1>"))
(global-set-key (kbd "C-M-<mouse-1>") 'mc/add-cursor-on-click)

;; iedit
(global-set-key (kbd "C-c i e")	'iedit-mode)



(provide 'init-multi-edit)
