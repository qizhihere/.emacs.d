(ispell-change-dictionary "american" t)
(setq-default ispell-program-name "ispell")

(dolist (hook '(text-mode-hook markdown-mode-hook org-mode-hook))
 (add-hook hook (lambda () (flyspell-mode 1))))

(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
 (add-hook hook (lambda () (flyspell-mode -1))))



(provide 'init-flyspell)
