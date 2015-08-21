(my/install 'yasnippet)

(after-load 'yasnippet
  (diminish 'yas-minor-mode)
  (silently-do (yas-reload-all))
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "C-j") 'yas-expand))

(add-hook 'prog-mode-hook 'yas-minor-mode)



(provide 'init-yasnippet)
