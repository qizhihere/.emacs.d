;; these packages is commonly used by other packages,
;; so i add it here.
(lqz/require '(key-chord popup pos-tip ag))

;; emacs default language (such as org-mode timestamp)
(setq system-time-locale "C")

(lqz/mkrdir '("session" "tmp/undodir" "tmp/auto-save"))


(setq temporary-file-directory (lqz/init-dir "tmp/"))
(setq auto-save-list-file-prefix (lqz/init-dir "tmp/auto-save/.saves-"))
(setq recentf-save-file (lqz/init-dir "tmp/recentf"))

(setq-default
      desktop-dirname             (lqz/init-dir "session/")
      desktop-base-file-name      "emacs.session"
      desktop-base-lock-name      "session-lock"
      desktop-path                (list desktop-dirname)
      desktop-save                t
      desktop-files-not-to-save   "^$" ;reload tramp path
      desktop-load-locked-desktop nil)
(desktop-save-mode 1)

;; store all backup and autosave files in the tmp dir
(setq lqz/backup-dir (lqz/init-dir "tmp/backup")
      backup-directory-alist		`((".*" . ,lqz/backup-dir))
      auto-save-file-name-transforms    `((".*" ,lqz/backup-dir t)))


;;--------------------------
;; edit settings
;;--------------------------
(lqz/require '(drag-stuff      ;; use M-arrow to move line or word
	       pcre2el))       ;; use pcre in emacs
(add-hook 'prog-mode-hook 'drag-stuff-mode)

;; auto fill prefix
(setq adaptive-fill-regexp "[ \t]+\\|[ \t]*\\([0-9]+\\.\\|\\*+\\|[ \t]*[\\+\\-]\\)[ \t]*")
(setq adaptive-fill-first-line-regexp "^\\* *$")


;; enable code folding
(add-hook 'prog-mode-hook 'hs-minor-mode)

(rxt-global-mode t)

;; enable eldoc
(lqz/require 'eldoc)
(eldoc-mode 1)

;; open current file with sudo
(require 'init-sudo-edit)

;; system clipboard support(use xsel, linux only)
(require 'init-clipboard)

;; enable shift+arrow key to select text
(setq shift-select-mode t)

;; set tab width
(setq indent-tabs-mode nil)
(setq tab-width 4)
(setq c-basic-offset 4)

;; disable page jump when cursor scrolling to the margin
(setq scroll-margin 3
      scroll-conservatively 10000)



;;------------------------------
;; window settings
;;------------------------------
(winner-mode t)


;;--------------------------
;; other settings
;;--------------------------
;; startup scratch text
(setq initial-scratch-message
      (concat ";; Happy hacking " (or user-login-name "") " - Emacs ♥ you!\n\n"))

;; set title bar text format
(setq frame-title-format "emacs@%b")

;; turn off alarms
(setq ring-bell-function 'ignore)



(provide 'init-basic)
