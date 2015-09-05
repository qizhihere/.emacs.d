(my/install 'sass-mode)

(my/install 'css-eldoc)
(autoload 'turn-on-css-eldoc "css-eldoc")
(add-hook 'css-mode-hook 'turn-on-css-eldoc)

(add-auto-mode 'sass-mode "\\.scss\\'")


(provide 'init-css)
