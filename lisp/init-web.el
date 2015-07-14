(lqz/require '(web-mode web-beautify
		emmet-mode helm-emmet
		css-eldoc js2-mode
		jade-mode coffee-mode
		sass-mode))

;; html
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\.twig\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.blade.php\\'" . web-mode))
;; html indent offset
(setq web-mode-markup-indent-offset 2)

;; css
(add-hook 'css-mode-hook 'emmet-mode)

;; emmet
(add-hook 'web-mode-hook 'emmet-mode)

;; js
(defun lqz/js2-setup ()
  (setq comment-start "/*" comment-end "*/")
  (subword-mode 1))
(add-hook 'js2-mode-hook 'lqz/js2-setup)
(setq-default js2-basic-offset 2
	      js-indent-level  2)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

;; coffeescript
(custom-set-variables '(coffee-tab-width 2))
(define-key coffee-mode-map (kbd "M-r r") 'coffee-compile-region)
(define-key coffee-mode-map (kbd "M-r b") 'coffee-compile-buffer)
(define-key coffee-mode-map (kbd "M-r f") 'coffee-compile-file)


(provide 'init-web)
