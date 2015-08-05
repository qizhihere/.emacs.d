(lqz/require '(indent-guide aggressive-indent))

;;----------------------------------------------------------------------------
;; indent guide
;;----------------------------------------------------------------------------
(defun lqz/indent-guide ()
  (if (< (count-lines (point-min) (point-max)) 500)
      (indent-guide-mode)))
;; (add-hook 'prog-mode-hook 'lqz/indent-guide)
(add-hook 'web-mode-hook 'lqz/indent-guide)
(setq indent-guide-recursive t
      ;; indent-guide-char "│"
      indent-guide-inhibit-modes
      '(dired-mode package-menu-mode))

;;----------------------------------------------------------------------------
;; aggressive indent
;;----------------------------------------------------------------------------
(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
(add-hook 'css-mode-hook #'aggressive-indent-mode)
(add-hook 'js2-mode-hook #'aggressive-indent-mode)


(provide 'init-indent)
