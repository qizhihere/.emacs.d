;;==========================
;; Appearance settings
;;==========================

;; load theme
(lqz/require 'zenburn-theme)
(load-theme 'zenburn t)

;; smart mode line
(lqz/require 'smart-mode-line)
;; (setq sml/vc-mode-show-backend t)
(setq sml/no-confirm-load-theme t)
(setq sml/theme 'respectful)
(sml/setup)

;; nyan cat on mode line
(lqz/require 'nyan-mode)
(nyan-mode t)

;; relative line number
(lqz/require 'linum-relative)
(global-linum-mode t)
;; adjust space between line number and content
(setq linum-relative-format "%3s ")

;; show column number, file size and battery on mode line
(column-number-mode t)
(size-indication-mode t)
(display-battery-mode t)

;; disable menubar
(menu-bar-mode -1)

;; highlight trailling whitespace
(lqz/require 'highlight-chars)
(add-hook 'prog-mode-hook 'hc-highlight-trailing-whitespace)

;; highlight brackets and quotes
(lqz/require 'highlight-parentheses)
(show-paren-mode t)
(setq show-paren-style 'mixed)
(global-highlight-parentheses-mode t)

;; highlight-sexp
(lqz/require 'highlight-sexp)
(add-hook 'lisp-mode-hook 'highlight-sexp-mode)
(add-hook 'emacs-lisp-mode-hook 'highlight-sexp-mode)
(setq hl-sexp-background-color "#333333")

;; highlight-symbol
(lqz/require 'highlight-symbol)
;; (highlight-symbol-mode t)
(add-hook 'prog-mode-hook 'highlight-symbol-mode)

(lqz/require 'indent-guide)
;; (set-face-background 'indent-guide-face "dimgray")
;; (setq indent-guide-delay 0.1)
(indent-guide-global-mode)
(setq indent-guide-recursive t)
(setq indent-guide-char "│")
(setq indent-guide-inhibit-modes '(dired-mode package-menu-mode))


;; auto strip whitespace when saving file
(add-hook 'before-save-hook (lambda () (whitespace-cleanup)))

;; highlight current line
;; (global-hl-line-mode -1)
;; (set-face-background 'hl-line "#404040")

;; directly show colors like hex colors and so on
(lqz/require 'rainbow-mode)
(rainbow-mode t)

;; autoclose brackets and quotes
(lqz/require 'autopair)
(electric-pair-mode t)

;; show search counts in mode line
(lqz/require 'anzu)
;; anzu(show search and replace info on mode line)
(global-anzu-mode +1)
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

;; show breadcrumbs in mode line or header line
(lqz/require 'info+)



(provide 'init-style)
