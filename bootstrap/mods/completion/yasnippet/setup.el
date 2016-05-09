(setq yasnippet-packages '(yasnippet))

(defun yasnippet/init ()
  (use-package yasnippet
    :init
    (add-hook 'prog-mode-hook #'yas-minor-mode)
    :diminish yas-minor-mode
    :bind (:map yas-minor-mode-map
           ("M-j" . yas-expand))
    :config
    (silently (yas-reload-all))))
