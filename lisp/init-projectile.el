(lqz/require '(helm-projectile))

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(setq projectile-enable-caching t)
(helm-projectile-on)



(provide 'init-projectile)
