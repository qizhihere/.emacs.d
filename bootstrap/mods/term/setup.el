(setq term-packages '(multi-term))

(defun term/init ()
  (use-package term
    :defer t
    :config
    (defun m|term-basic-setup ()
      (setq show-trailing-whitespace nil
            transient-mark-mode nil
            scroll-margin 0
            truncate-lines t))
    (add-hook 'term-mode-hook #'m|term-basic-setup)

    (loaded yasnippet
      (add-hook 'term-mode-hook (lambda () (yas-minor-mode -1))))

    (defun m|xpaste-to-term ()
      "`xpaste' to terminal."
      (interactive)
      (term-send-raw-string (xpaste t)))
    (add-hook 'term-mode-hook
              (lambda () (bind-keys :map term-raw-map
                       ("C-c cp" . m|xpaste-to-term))))))

(defun term/init-multi-term ()
  (use-package multi-term
    :bind (("<f12>" . multi-term-dedicated-toggle)
           ("C-<f12>" . multi-term))
    :config
    (setq multi-term-dedicated-select-after-open-p t)

    (merge-to term-bind-key-alist
      '(("M-d" . term-send-forward-kill-word)
        ("M-DEL" . term-send-backward-kill-word)))))
