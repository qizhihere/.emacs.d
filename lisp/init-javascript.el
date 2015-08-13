(my/install 'js3-mode)
(after-load "js3-mode"
  (derived-from-prog-mode 'js3-mode)
  (setq-default js-indent-level 2)
  (subword-mode 1)
  (custom-set-variables
   '(js3-indent-dots t)
   '(js3-lazy-commas t)
   '(js3-expr-indent-offset 2)
   '(js3-paren-indent-offset 2)
   '(js3-square-indent-offset 2)
   '(js3-curly-indent-offset 2))

  ;; company-tern(semantic completion for javascript)
  (with-installed 'company
	(my/require '(tern company-tern))
	(add-to-list 'company-backends 'company-tern)
	(setq company-tern-meta-as-single-line t
		  company-tooltip-align-annotations t)
	(add-hook 'js3-mode-hook (lambda () (tern-mode 1)))))

(add-auto-mode 'js3-mode "\\.\\(js\\|json\\)\\'")
(add-to-list 'interpreter-mode-alist '("node" . js3-mode))


;; coffeescript
(my/install 'coffee-mode)
;; coffeescript
(after-load "coffee-mode"
  (custom-set-variables '(coffee-tab-width 2))
  (define-key coffee-mode-map (kbd "M-r r") 'coffee-compile-region)
  (define-key coffee-mode-map (kbd "M-r b") 'coffee-compile-buffer)
  (define-key coffee-mode-map (kbd "M-r f") 'coffee-compile-file))



(provide 'init-javascript)
