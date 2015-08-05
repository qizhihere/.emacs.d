(lqz/require '(aggressive-indent))

;;----------------------------------------------------------------------------
;; aggressive indent
;;----------------------------------------------------------------------------
(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
(add-hook 'css-mode-hook #'aggressive-indent-mode)
(add-hook 'js2-mode-hook #'aggressive-indent-mode)


(provide 'init-indent)
