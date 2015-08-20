;; term settings
(my/install 'multi-term)
(setq multi-term-program "/usr/bin/fish")

(after-init
  (let ((term (if (package-installed-p 'multi-term) 'multi-term 'ansi-term)))
    (global-set-key [f12] term)))

(after-load 'multi-term
  (global-set-key (kbd "C-<f12>") 'multi-term-next)
  (global-set-key (kbd "M-<f12>") 'multi-term-prev))

(add-hook 'term-mode-hook
          (lambda ()
            (setq show-trailing-whitespace nil)
            (electric-pair-mode 1)
            (setq truncate-lines nil)
            (setq term-prompt-regexp "^.*\\(❯❯❯\\|»\\|➤➤\\) ")
            (make-local-variable 'mouse-yank-at-point)
            (setq mouse-yank-at-point t)
            (make-local-variable 'transient-mark-mode)
            (setq transient-mark-mode nil)
            (setq yas-dont-activate t)))


(provide 'init-ansi-term)
