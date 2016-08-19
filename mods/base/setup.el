(defun base/init ()
  (mkdir m|cache-dir t)
  (base/reset-options)
  (base/inhibit-startup-messages)
  (fset 'yes-or-no-p 'y-or-n-p))

(defun base/init-startup-time ()
  (m|load-conf "startup-time" base)
  (startup-time/setup))

(defun base/init-custom-file ()
  (setq custom-file (m|home (if window-system "custom-gui.el"
                              "custom-console.el"))))

(defun base/init-autosave ()
  (let ((auto-save-dir (m|cache-dir "auto-save")))
    (unless (file-directory-p auto-save-dir)
      (mkdir auto-save-dir t))
    (setq auto-save-interval 60
          auto-save-timeout 60
          auto-save-list-file-prefix (concat auto-save-dir "/.saves-")
          auto-save-file-name-transforms `((".*" ,auto-save-dir t)))))

(defun base/inhibit-startup-messages ()
  (setq initial-scratch-message ""
        initial-major-mode 'text-mode
        inhibit-startup-screen t
        inhibit-startup-message t
        inhibit-startup-echo-area-message t)
  (defun display-startup-echo-area-message ()))

(defun base/reset-options ()
  (setq-default
   tab-width 4  ;; no evil tabs
   indent-tabs-mode nil
   buffers-menu-max-size 30
   delete-selection-mode t
   eshell-directory-name (m|cache-dir "eshell")
   help-window-select t
   make-backup-files nil
   mode-require-final-newline t
   require-final-newline t
   save-interprogram-paste-before-kill t
   scroll-preserve-screen-position 'always
   shift-select-mode t
   show-trailing-whitespace nil
   tooltip-delay 1.5
   truncate-lines nil
   truncate-partial-width-windows nil
   tramp-persistency-file-name (m|cache-dir "tramp")
   tramp-histfile-override (m|cache-dir "tramp_history")
   vc-follow-symlinks t
   blink-cursor-interval 0.4
   revert-without-query '(".*")
   url-cookie-file (m|cache-dir "url_cookies"))

  (setq kill-ring-max 1000
        scroll-margin 3
        scroll-conservatively 10000
        frame-title-format "emacs@%b"
        ring-bell-function nil
        visible-bell nil
        temporary-file-directory "/tmp/emacs"
        x-select-enable-clipboard nil
        system-time-locale "C"
        auto-save-default nil
        backup-inhibited t
        url-configuration-directory (m|cache-dir "/url"))
  (mkdir temporary-file-directory t)

  ;; System locale to use for formatting time values.
  (setq system-time-locale "C")
  (set-locale-environment m|locale-environment)

  ;; enable `narrow-to-region'
  (put 'narrow-to-region 'disabled nil))

(defun base/init-keys ()
  (loaded info
    (bind-keys :map Info-mode-map
      ("l" . Info-history)
      ("H" . Info-history-back)
      ("L" . Info-history-forward)))

  (loaded help-mode
    (bind-keys :map help-mode-map
      ("H" . help-go-back)
      ("L" . help-go-forward))))

(defun base/init-compilation ()
  (loaded compile
    (require 'ansi-color)
    (defun compilation-mode-colorize ()
      (when (eq major-mode 'compilation-mode)
        (toggle-read-only)
        (ansi-color-apply-on-region compilation-filter-start (point))
        (toggle-read-only)))
    (add-hook 'compilation-filter-hook 'compilation-mode-colorize)))
