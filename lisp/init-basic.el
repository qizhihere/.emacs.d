;; these packages is commonly used by other packages,
;; so i add it here.
(lqz/require '(key-chord popup pos-tip))

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
;; sudo edit(reopen with sudo)
(lqz/require '(sudo-edit    ;; open current file with sudo
	       simpleclip   ;; system clipboard support
	       drag-stuff   ;; use M-arrow to move line or word
	      ))

;; system clipboard support
(simpleclip-mode 1)

;; enable shift+arrow key to select text
(setq shift-select-mode t)

;; set tab width
(setq tab-width 4)
(setq indent-tabs-mode nil)

;; make tab key call indent command or insert tab character,
;; depending on cursor position
(setq-default tab-always-indent nil)


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
