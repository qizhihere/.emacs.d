(lqz/require 'outline-magic)

(add-hook 'prog-mode-hook 'outline-minor-mode)

(add-hook 'outline-mode-hook
          (lambda ()
            (require 'outline-cycle)))

(add-hook 'outline-minor-mode-hook
          (lambda ()
            (require 'outline-magic)
            (define-key evil-normal-state-map [S-tab] 'outline-cycle)
            (define-key evil-normal-state-map [M-up] 'outline-move-subtree-up)
            (define-key evil-normal-state-map [M-down] 'outline-move-subtree-down)
            (define-key evil-normal-state-map [M-left] 'outline-promote)
            (define-key evil-normal-state-map [M-right] 'outline-demote)))



(provide 'init-outline)
