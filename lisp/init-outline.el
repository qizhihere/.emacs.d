(lqz/require 'outline-magic)

(add-hook 'prog-mode-hook 'outline-minor-mode)

(add-hook 'outline-minor-mode-hook
	  (lambda ()
	    (require 'outline-magic)
	    (define-key evil-normal-state-map [backtab] 'outline-cycle)
	    (define-key evil-normal-state-map [M-up] 'outline-move-subtree-up)
	    (define-key evil-normal-state-map [M-down] 'outline-move-subtree-down)
	    (define-key evil-normal-state-map [M-left] 'outline-promote)
	    (define-key evil-normal-state-map [M-right] 'outline-demote)
	    ))

(define-key outline-minor-mode-map (kbd "C-o h a")  'outline-hide-sublevels)
(define-key outline-minor-mode-map (kbd "C-o h b")  'outline-hide-body)
(define-key outline-minor-mode-map (kbd "C-o h e")  'outline-hide-entry)
(define-key outline-minor-mode-map (kbd "C-o h s")  'outline-hide-subtree)
(define-key outline-minor-mode-map (kbd "C-o h h")  'outline-hide-subtree)
(define-key outline-minor-mode-map (kbd "C-o h l")  'outline-hide-leaves)



(provide 'init-outline)
