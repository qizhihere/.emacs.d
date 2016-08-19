(setq go-packages '(go-mode
                    go-eldoc
                    company-go))

(defun go/init ()
  (use-package go-mode
    :defer t
    :init
    (add-hook 'before-save-hook
              (lambda () (when (eq major-mode 'go-mode) (gofmt))))))

(defun go/init-eldoc ()
  (use-package go-eldoc
    :defer t
    :init
    (add-hook 'go-mode-hook #'go-eldoc-setup)))

(defun go/init-completion ()
  (loaded company-utils
    (defun m|company-add-go-backend ()
      (company/add-local-backend 'company-go))
    (add-hook 'go-mode-hook #'m|company-add-go-backend)))
