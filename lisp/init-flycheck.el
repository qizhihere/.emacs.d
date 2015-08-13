(my/install 'flycheck)

(after-init (global-flycheck-mode))

(after-load 'flycheck
  (with-installed 'helm
	(my/try-install 'helm-flycheck))
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (setq flycheck-idle-change-delay 2))


(provide 'init-flycheck)
