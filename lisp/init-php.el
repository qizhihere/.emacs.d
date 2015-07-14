(lqz/require '(php-mode php-extras php-eldoc))

(add-hook 'php-mode-hook 'php-enable-default-coding-style)
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . php-mode))
(setq php-lineup-cascaded-calls t)



(provide 'init-php)
