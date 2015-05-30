;;==============================
;; simple minor mode settings
;;==============================

;; vimrc mode
(lqz/require 'vimrc-mode)
(add-to-list 'auto-mode-alist '("\\.vim\\(rc\\)?\\'" . vimrc-mode))

;; fish mode
(lqz/require 'fish-mode)
(add-to-list 'auto-mode-alist '("\\.fish\\(rc\\)?\\'" . fish-mode))

;; nginx mode
(lqz/require 'nginx-mode)
(add-to-list 'auto-mode-alist '("/etc/nginx/.*" . nginx-mode))



(provide 'init-other-minor-mode)
