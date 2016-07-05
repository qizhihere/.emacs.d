(setq go-packages '(go-mode go-eldoc))

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
