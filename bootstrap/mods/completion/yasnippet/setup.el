(setq yasnippet-packages '(yasnippet))

(defun yasnippet/init ()
  (use-package yasnippet
    :init
    (add-hook 'prog-mode-hook #'yas-minor-mode)
    :diminish yas-minor-mode
    :bind (:map yas-minor-mode-map
           ("M-j" . yas-expand))
    :config
    (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
    (add-hook 'snippet-mode (lambda () (setq-local m|whitespace-cleanup-style 'trailing)))

    (loaded company
      (defun m|company-yasnippet ()
        "Indent with `indent-for-tab-command', or show yasnippet candidates."
        (interactive)
        (let ((pos (point)))
          (indent-for-tab-command)
          (when (eq pos (point))
            (call-interactively #'company-yasnippet))))
      (bind-key "<tab>" #'m|company-yasnippet yas-minor-mode-map))

    (silently (yas-reload-all))))
