(lqz/require '(helm-projectile))

(add-hook 'prog-mode-hook 'projectile-mode)
(setq projectile-completion-system 'helm
      projectile-enable-caching t)

(add-more-to-list 'projectile-globally-ignored-directories '("vendor"))

(helm-projectile-on)



(provide 'init-projectile)
