(ispell-change-dictionary "american" t)
(setq-default ispell-program-name "ispell")

(setq-default flyspell-mode t)

(dolist (hook '(text-mode-hook markdown-mode-hook org-mode-hook))
 (add-hook hook (lambda () (flyspell-mode 1))))



(provide 'init-flyspell)
