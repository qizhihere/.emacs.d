(my/install 'eldoc)
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(remove-hook 'emacs-lisp-mode-hook 'flycheck-mode)
(after-load 'eldoc
  (diminish 'eldoc-mode))



(provide 'init-lisp)
