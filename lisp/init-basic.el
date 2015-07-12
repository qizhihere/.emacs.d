;; these packages is commonly used by other packages,
;; so i add it here.
(lqz/require '(key-chord popup pos-tip))

;; emacs default language (such as org-mode timestamp)
(setq system-time-locale "C")

;;--------------------------
;; directories settings
;;--------------------------
;; create some essential directories
(lqz/mkrdir '("session" "tmp/undodir" "tmp/auto-save"))

;; set emacs temporary directory
(setq temporary-file-directory (lqz/init-dir "tmp/"))

;; auto-save files path
(setq auto-save-list-file-prefix (lqz/init-dir "tmp/auto-save/.saves-"))

;; recent files list path
(setq recentf-save-file (lqz/init-dir "tmp/recentf"))

;; automatically save and restore sessions
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
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-basic-offset 4)

;; automaticaly save
;; (lqz/require 'real-auto-save)
;; (add-hook 'prog-mode-hook 'real-auto-save-mode)
;; (add-hook 'org-mode-hook 'real-auto-save-mode)
;; (setq real-auto-save-interval 5) ;; in seconds
;; (setq auto-save-interval 5
;;       auto-save-timeout 5)


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

;; turn off alarms
(setq ring-bell-function 'ignore)



(provide 'init-basic)
