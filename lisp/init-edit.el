;; default settings
(setq-default
 blink-cursor-interval 0.4
 bookmark-default-file (my/init-dir "tmp/.bookmarks.el")
 buffers-menu-max-size 30
 case-fold-search t
 delete-selection-mode t
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-windows-plain
 make-backup-files nil
 mouse-yank-at-point t
 save-interprogram-paste-before-kill t
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 shift-select-mode t
 show-trailing-whitespace nil
 tooltip-delay 1.5
 truncate-lines nil
 truncate-partial-width-windows nil
 visible-bell nil)

;; try install helm-bm
(with-installed 'helm
  (my/try-install 'helm-bm))

(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t
	  auto-revert-verbose nil)

(transient-mark-mode t)

;; no evil tabs
(setq-default tab-width 4)
(setq indent-tabs-mode nil)

;; strip whitespace when saving file
(add-hook 'before-save-hook (lambda () (whitespace-cleanup)))

;; use system clipboard copy/cut/paste
(autoload 'xcopy "system-clipboard" "Copy region to the system clipboard." t)
(autoload 'xpaste "system-clipboard" "Paste content of system clipboard into buffer." t)
(autoload 'xcut "system-clipboard" "Cut region to system clipboard." t)


;;----------------------------------------------------------------------------
;; multiple/region edit
;;----------------------------------------------------------------------------
(my/install 'multiple-cursors)

(after-load 'multiple-cursors
  (set mc/list-file (my/init-dir "tmp/.mc-lists.el")))

;; multiple cursors
(global-unset-key (kbd "C-<down-mouse-1>"))
(global-set-key (kbd "C-<mouse-1>") 'mc/add-cursor-on-click)

;; multiple-cursors
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-+") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; From active region to multiple cursors:
(global-set-key (kbd "C-c c r") 'set-rectangular-region-anchor)
(global-set-key (kbd "C-c c c") 'mc/edit-lines)
(global-set-key (kbd "C-c c e") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-c c a") 'm-beginnings-of-lines)


;;----------------------------------------------------------------------------
;; highlight
;;----------------------------------------------------------------------------
;; brackets and quotes
(my/install 'highlight-parentheses)
(show-paren-mode 1)
(global-highlight-parentheses-mode 1)
(diminish 'highlight-parentheses-mode)

;; symbol
(my/install 'highlight-symbol)
(after-load 'highlight-symbol
  (diminish 'highlight-symbol-mode)
  (setq highlight-symbol-idle-delay 0.3)
  (defadvice highlight-symbol-temp-highlight (around sanityinc/maybe-suppress activate)
	"Suppress symbol highlighting while isearching."
	(unless (or isearch-mode
				(and (boundp 'multiple-cursors-mode) multiple-cursors-mode))
	  ad-do-it)))

(dolist (hook '(prog-mode-hook css-mode-hook html-mode-hook))
  (add-hook hook 'highlight-symbol-mode))


;; directly show colors like hex colors and so on
(my/install '(rainbow-mode rainbow-delimiters))
(after-load 'rainbow-mode
  (diminish 'rainbow-mode))
(add-hook 'prog-mode-hook
		  (lambda () (rainbow-mode) (rainbow-delimiters-mode)))


;; code folding and auto pairs/brackets
(my/install '(smartparens hideshowvis))
(defun my/edit-hooks ()
  ;; highlight whitespace
  (setq show-trailing-whitespace t)
  (require 'smartparens-config)
  (turn-on-smartparens-mode)
  (hs-minor-mode 1)
  (hideshowvis-enable)
  (hideshowvis-symbols))
(add-hook 'prog-mode-hook 'my/edit-hooks)
(after-load 'hideshow (diminish 'hs-minor-mode))
(after-load 'smartparens (diminish 'smartparens-mode))

;; automatically indent code on editing
(my/install '(aggressive-indent))
(dolist (x '(emacs-lisp-mode-hook
			 css-mode-hook
			 js2-mode-hook))
  (and (boundp x) (add-hook x (lambda () (when (< (count-lines (point-min) (point-max)) 500)
									   (aggressive-indent-mode 1))))))
(after-load 'aggressive-indent
  (diminish 'aggressive-indent-mode))

(after-load 'subword (diminish 'subword-mode))
(after-load 'abbrev (diminish 'abbrev-mode))

(when (fboundp 'global-prettify-symbols-mode)
  (global-prettify-symbols-mode))

;; use regex tool to test regular expression
(my/install 'regex-tool)
(after-load 'regex-tool
  (setq regex-tool-backend 'perl)
  (with-installed 'evil
	(add-hook 'regex-tool-mode-hook
			  (lambda () (evil-local-set-key 'normal [remap evil-record-macro] 'regex-tool-quit)))))


(provide 'init-edit)
