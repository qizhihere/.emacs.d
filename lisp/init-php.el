(lqz/require '(php-mode php-extras php-eldoc))

(defun lqz/php-setup ()
  (php-enable-default-coding-style)
  (subword-mode 1)
  (setq php-lineup-cascaded-calls t))

(add-hook 'php-mode-hook 'lqz/php-setup)
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . php-mode))



(provide 'init-php)
