(lqz/require '(helm-projectile))

(add-hook 'prog-mode-hook 'projectile-mode)
(setq projectile-completion-system 'helm)
(setq projectile-enable-caching t)
(helm-projectile-on)



(provide 'init-projectile)
