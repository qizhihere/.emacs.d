(lqz/require '(web-mode web-beautify
                emmet-mode helm-emmet
                css-eldoc js2-mode
                jade-mode))

;; html
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\.twig\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.blade.php\\'" . web-mode))

;; css
(add-hook 'css-mode-hook 'emmet-mode)

;; emmet
(add-hook 'web-mode-hook 'emmet-mode)

;; js
(defun lqz/js-mode ()
  (js2-minor-mode 1)
  (setq comment-start "/*"
        comment-end "*/"))
(add-hook 'js-mode-hook 'lqz/js-mode)
(setq-default js2-basic-offset 2
              js-indent-level  2)
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

;; asp
(add-to-list 'auto-mode-alist '("\\.aspx?\\'" . web-mode))



(provide 'init-web)
