(my/install '(php-mode php-extras php-eldoc))

(after-load 'php-mode
  (add-hook 'php-mode-hook
			(lambda () (subword-mode 1)
			  (setq php-lineup-cascaded-calls t)
			  (php-enable-default-coding-style)
			  (php-eldoc-enable))))



(provide 'init-php)
