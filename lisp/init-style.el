;;==========================
;; Appearance settings
;;==========================

;; smart mode line
(lqz/require 'smart-mode-line)
;; (setq sml/vc-mode-show-backend t)
(setq sml/no-confirm-load-theme t
	  sml/theme 'respectful
	  sml/mode-width 'full
	  sml/name-width (cons 1 20))
(sml/setup)

;; hide some minor modes from mode line
(setq lqz/rm-blacklist-regexps
	  '("Guide" "Git" "Outl" "snipe" "Anzu" "company"
		"Undo-Tree" "hs" "ivy" "yas" "hl-" "Helm"
		"Rbow" "drag"))
(setq rm-blacklist (mapconcat 'identity lqz/rm-blacklist-regexps "\\|"))

;; show current time in mode line
(display-time-mode t)

;; nyan cat on mode line
(lqz/require 'nyan-mode)
(nyan-mode t)

;; relative line number
(lqz/require 'linum-relative)

;; adjust space between line number and content
(setq linum-relative-current-symbol "=>")
(setq linum-relative-format (if (display-graphic-p) "%3s" "%3s "))
(global-linum-mode)
(defun lqz/linum-off () (linum-mode -1))
(add-hook 'org-mode-hook 'lqz/linum-off)

;; show column number and file size on mode line
(column-number-mode t)
(size-indication-mode t)

;; disable menubar
(menu-bar-mode -1)

;; highlight trailling whitespace
(lqz/require 'highlight-chars)
(add-hook 'prog-mode-hook 'hc-highlight-trailing-whitespace)

;; highlight brackets and quotes
(lqz/require 'highlight-parentheses)
(show-paren-mode t)
(setq show-paren-style 'mixed)
;; (set blink-matching-paren nil)
(global-highlight-parentheses-mode t)

;; highlight-sexp
(lqz/require 'highlight-sexp)
(add-hook 'lisp-mode-hook 'highlight-sexp-mode)
(add-hook 'emacs-lisp-mode-hook 'highlight-sexp-mode)

;; highlight-symbol
(lqz/require 'highlight-symbol)
;; (highlight-symbol-mode t)
(setq highlight-symbol-idle-delay 0.3)
(add-hook 'prog-mode-hook 'highlight-symbol-mode)

;; auto strip whitespace when saving file
(add-hook 'before-save-hook (lambda () (whitespace-cleanup)))

;; directly show colors like hex colors and so on
(lqz/require 'rainbow-mode)
(add-hook 'prog-mode-hook 'rainbow-mode)

;; autoclose brackets and quotes
(lqz/require 'autopair)
(electric-pair-mode t)
(electric-quote-mode t)

;; show search counts in mode line
(lqz/require 'anzu)
;; anzu(show search and replace info on mode line)
(global-anzu-mode +1)
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

;; show breadcrumbs in mode line or header line
(lqz/require 'info+)



(provide 'init-style)
