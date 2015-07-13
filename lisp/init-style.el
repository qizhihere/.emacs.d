;;==========================
;; Appearance settings
;;==========================

;; smart mode line
(lqz/require 'smart-mode-line)
;; (setq sml/vc-mode-show-backend t)
(setq sml/no-confirm-load-theme t)
(setq sml/theme 'respectful)
(sml/setup)

;; nyan cat on mode line
(lqz/require 'nyan-mode)
(nyan-mode t)

;; show battery status on mode line
(lqz/require 'fancy-battery)
(add-hook 'after-init-hook #'fancy-battery-mode)
(display-battery-mode -1)


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


(lqz/require 'indent-guide)
(defun lqz/indent-guide () (if (< (count-lines (point-min) (point-max)) 500) (indent-guide-mode)))
(add-hook 'prog-mode-hook 'lqz/indent-guide)
(add-hook 'web-mode-hook 'lqz/indent-guide)
(setq indent-guide-recursive t)
;; (setq indent-guide-char "│")
(setq indent-guide-inhibit-modes '(dired-mode package-menu-mode))

;; auto strip whitespace when saving file
(add-hook 'before-save-hook (lambda () (whitespace-cleanup)))

;; directly show colors like hex colors and so on
(lqz/require 'rainbow-mode)
(add-hook 'prog-mode-hook 'rainbow-mode)

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
