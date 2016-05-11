(setq python-packages '(elpy))

(defun python/init ()
  (use-package python
    :defer t
    :config
    (setq python-shell-interpreter
          (or (executable-find "python2")
              (executable-find "python")))

    (loaded smartparens
      (require 'smartparens-python)
      (add-hook 'inferior-python-mode-hook #'smartparens-mode))))

(defun python/init-elpy ()
  (use-package elpy
    :defer t
    :diminish elpy-mode
    :init
    (loaded python (elpy-enable))

    :bind (:map elpy-mode-map
           ("M-<return>" . elpy-shell-send-current-statement))
    :config
    (setq elpy-rpc-python-command python-shell-interpreter)
    (unbind-key "C-<return>" elpy-mode-map)
    (unbind-key "S-<return>" elpy-mode-map)

    ;; setup company elpy backend
    (loaded company
      (defun m|company-add-elpy-backend ()
        (company/add-local-backend 'elpy-company-backend))
      (add-hook 'elpy-mode-hook #'m|company-add-elpy-backend))))

(defun python/init-repl ()
  (loaded python
    (define-repl python-repl ()
      "Run python interpreter."
      (run-python))

    (bind-keys :map python-mode-map
      ("C-c <f12>" . python-repl)
      ("C-c C-<f12>" . python-repl-maximized))))
