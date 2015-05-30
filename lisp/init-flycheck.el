(lqz/require '(flycheck flycheck-tip))

(add-hook 'after-init-hook #'global-flycheck-mode)

(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

;; (require 'flycheck-tip)
;; (define-key prog-mode-map (kbd "C-c C-n") 'flycheck-tip-cycle)
;; (define-key prog-mode-map (kbd "C-c C-p") 'flycheck-tip-cycle)



(provide 'init-flycheck)
