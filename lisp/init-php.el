(lqz/require '(php-mode php-extras php-eldoc))

(add-hook 'php-mode-hook 'php-enable-psr2-coding-style)
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . php-mode))
(setq php-lineup-cascaded-calls t)



(provide 'init-php)
