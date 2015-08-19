(my/install '(eldoc eldoc-eval ipretty))

;; eval-expression result pretty print
(ipretty-mode 1)
(defadvice pp-display-expression (after my/make-read-only (expression out-buffer-name) activate)
  "enable `view-mode' in the output buffer - if any - so it can be closed with `\"q\"."
  (when (get-buffer out-buffer-name)
	(with-current-buffer out-buffer-name
	  (view-mode 1)
	  (and (fboundp 'evil-change-state)
		   (evil-change-state 'emacs)))))

(remove-hook 'emacs-lisp-mode-hook 'flycheck-mode)
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'eldoc-mode-hook 'eldoc-in-minibuffer-mode)

(after-load 'eldoc (diminish 'eldoc-mode))
(add-hook 'lisp-interaction-mode-hook
		  (lambda () (setq mode-name "Lisp")))



(provide 'init-lisp)
