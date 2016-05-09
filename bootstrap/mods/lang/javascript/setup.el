(setq javascript-packages '(tern
                            company-tern
                            js2-mode
                            coffee-mode
                            emmet-mode
                            json-mode))

(defun javascript/init ()
  (use-package js
    :defer t
    :init
    (add-hook 'js-mode-hook #'subword-mode)
    :config
    (setq js-indent-level 2)
    (add-hook 'js-mode-hook #'emmet-mode)

    (loaded company-utils
      (add-hook 'js-mode-hook #'m|company-add-yasnippet-general-backend t))))

(defun javascript/init-tern ()
  (use-package tern
    :defer t
    :init
    (add-hook 'js-mode-hook #'tern-mode)
    :config
    (loaded company
      (defun m|company-add-tern-backend ()
        (company/add-local-backend 'company-tern))
      (add-hook 'tern-mode-hook #'m|company-add-tern-backend)))
  (use-package company-tern
    :defer t
    :config
    (setq company-tern-meta-as-single-line t)))

(defun javascript/init-js2 ()
  (use-package js2-mode
    :defer t
    :mode (("\\.jsx\\'" . js2-jsx-mode)
           ("\\.js\\'" . js2-mode))
    :interpreter "node"
    :config
    (setq js2-basic-offset 2
          js2-highlight-level 3
          js2-mode-show-parse-errors nil
          js2-mode-show-strict-warnings nil
          js2-strict-missing-semi-warning nil)

    (defun m|js2-setup ()
      (setq mode-name "js2")
      (js2-reparse t))
    (add-hook 'js2-mode-hook #'m|js2-setup)

    (use-package flycheck
      :ensure nil
      :commands flycheck-get-checker-for-buffer
      :config
      (defun m|enable-js2-checks-unless-flycheck ()
        (unless (flycheck-get-checker-for-buffer)
          (set (make-local-variable 'js2-mode-show-parse-errors) t)
          (set (make-local-variable 'js2-mode-show-strict-warnings) t)))
      (add-hook 'js2-mode-hook #'m|enable-js2-checks-unless-flycheck))))

(defun javascript/init-coffee ()
  (use-package coffee-mode
    :defer t
    :interpreter "node"
    :config
    (setq coffee-tab-width 2)
    (add-hook 'coffee-mode-hook #'subword-mode)

    (loaded hydra
      (defhydra hydra-coffee (:color blue)
        "Compile"
        ("r" coffee-compile-region "region")
        ("b" coffee-compile-buffer "buffer")
        ("f" coffee-compile-file "file"))
      (define-key coffee-mode-map (kbd "M-o") 'hydra-coffee/body))))
