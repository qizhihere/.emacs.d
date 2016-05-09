(setq php-packages '(php-mode
                     php-eldoc
                     ac-php))

(defun php/init ()
  (use-package php-mode
    :defer t
    :init
    (add-hooks 'php-mode-hook
               '(php-enable-default-coding-style
                 subword-mode))

    :config
    (setq-default php-lineup-cascaded-calls t)))

(defun php/init-completion ()
  (use-package ac-php-company
    :ensure ac-php
    :commands company-ac-php-backend)

  (loaded company-utils
    (defun m|company-add-ac-php-backend ()
      (company/add-local-backend 'company-ac-php-backend))
    (add-hooks 'php-mode-hook #'m|company-add-ac-php-backend)))

(defun php/init-eldoc ()
  (use-package php-eldoc
    :defer t
    :init
    (add-hook 'php-mode-hook #'php-eldoc-enable)

    :config
    ;; prevent auto-complete variable not defined error
    (defun m|php-eldoc-enable--fix-ac-error (orig-func &rest args)
      (let (auto-complete-mode)
        (apply orig-func args)))
    (advice-add 'php-eldoc-enable :around #'m|php-eldoc-enable--fix-ac-error)))
