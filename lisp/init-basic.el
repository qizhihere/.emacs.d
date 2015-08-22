;;----------------------------------------------------------------------------
;; the most basic settings
;;----------------------------------------------------------------------------
;; add custom bin directory to PATH
(add-to-list 'exec-path (my/init-dir "utils/bin"))

;; replace default M-x with smex
(my/install 'smex)
(global-set-key [remap execute-extended-command] 'smex)
(setq smex-save-file (my/init-dir "tmp/smex-items"))

(dolist (x '("tmp" "tmp/auto-save" "tmp/backup"))
  (let ((dir (my/init-dir x)))
    (or (file-exists-p dir) (mkdir dir))))

;; move into temporary directories
(setq temporary-file-directory (my/init-dir "tmp/")
      recentf-save-file (my/init-dir "tmp/recentf")
      my/backup-dir (my/init-dir "tmp/backup")
      backup-directory-alist		`((".*" . ,my/backup-dir))
      auto-save-list-file-prefix (my/init-dir "tmp/auto-save/.saves-")
      auto-save-file-name-transforms    `((".*" ,my/backup-dir t))
      tramp-histfile-override (my/init-dir "tmp/.tramp_history")
      tramp-persistency-file-name (my/init-dir "tmp/tramp"))

(setq auto-save-interval 60
      auto-save-timeout 60)

(defadvice recentf-cleanup (around recentf-cleanup-silently activate)
  (silently-do ad-do-it))
(after-init (ad-deactivate #'recentf-cleanup))


;;----------------------------------------------------------------------------
;; edit settings
;;----------------------------------------------------------------------------
;; System locale to use for formatting time values.
(setq system-time-locale "C")

;; set defualt coding system
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; disable automatically copy selected region to x clipboard
(setq x-select-enable-clipboard nil)

;; open current file with sudo
(require 'sudo-edit)

;; set default shell
(setenv "SHELL" "/bin/bash")
(setq tramp-shell-prompt-pattern "^.*$")

;; disable page jump when cursor scrolling to the margin
(setq scroll-margin 3
      scroll-conservatively 10000)

;;----------------------------------------------------------------------------
;; other settings
;;----------------------------------------------------------------------------
;; enable window undo/redo
(winner-mode t)

;; startup settings
(setq initial-scratch-message
      (concat ";; Happy hacking " (or user-login-name "") " - Emacs ♥ you!\n\n")
      inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;; set title bar text format
(setq frame-title-format "emacs@%b")

;; turn off alarms
(setq ring-bell-function 'nil)

(defalias 'yes-or-no-p 'y-or-n-p)
(my/install 'fullframe)



(provide 'init-basic)
