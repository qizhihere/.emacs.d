(lqz/require 'yasnippet)

(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "C-j") 'yas-expand)
(yas-global-mode t)



(provide 'init-yasnippet)
