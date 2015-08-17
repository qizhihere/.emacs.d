(my/install 'js2-mode)

(after-load "js2-mode"
  (derive-from-prog-mode 'js2-mode)

  (setq-default js2-mode-show-parse-errors nil
				js2-mode-show-strict-warnings nil)

  (setq js2-basic-offset 2
		js2-highlight-level 3)

  (subword-mode 1)

  (with-installed 'flycheck
	(autoload 'flycheck-get-checker-for-buffer "flycheck")
	(defun my/disable-js2-checks-if-flycheck-active ()
	  (unless (flycheck-get-checker-for-buffer)
		(set (make-local-variable 'js2-mode-show-parse-errors) t)
		(set (make-local-variable 'js2-mode-show-strict-warnings) t)))
	(add-hook 'js2-mode-hook 'my/disable-js2-checks-if-flycheck-active))

  (with-installed 'paredit
	(define-key js2-mode-map "{" 'paredit-open-curly)
	(define-key js2-mode-map "}" 'paredit-close-curly-and-newline))

  ;; company-tern(semantic completion for javascript)
  (with-installed 'company
	(my/require '(tern company-tern))
	(add-to-list 'company-backends 'company-tern)
	(setq company-tern-meta-as-single-line t
		  company-tooltip-align-annotations t)
	(add-hook 'js2-mode-hook
			  (lambda () (setq mode-name "js2") (tern-mode 1)))))

(my/install 'json-mode)
(add-auto-mode 'json-mode "\\.\\(json\\)\\'")
(add-auto-mode 'js2-mode "\\.\\(js\\)\\'")
(dolist (mode '(js2-mode json-mode))
  (add-to-list 'interpreter-mode-alist `("node" . ,mode)))


;; coffeescript
(my/install 'coffee-mode)
;; coffeescript
(after-load "coffee-mode"
  (custom-set-variables '(coffee-tab-width 2))
  (define-key coffee-mode-map (kbd "M-r r") 'coffee-compile-region)
  (define-key coffee-mode-map (kbd "M-r b") 'coffee-compile-buffer)
  (define-key coffee-mode-map (kbd "M-r f") 'coffee-compile-file))



(provide 'init-javascript)
