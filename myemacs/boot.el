(add-to-list 'load-path (expand-file-name "core" m|conf))

(require 'core-vars)
(require 'core-helpers)
(m|add-path (m|conf "bin"))

;; initialize package system
(require 'core-elpa)
(unless (require 'quelpa nil t)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))
(unless (require 'quelpa-use-package nil t)
  (quelpa '(quelpa-use-package :fetcher github
                               :repo "quelpa/quelpa-use-package")))
(setq use-package-always-ensure t)
(quelpa-use-package-activate-advice)

(require 'cl)
(require 'core-mods)
(require 'core-use-package-ext)

;; setup startup idle timer
(defvar startup-idle-hook '())
(defvar startup-idle-timer nil)
(defun setup-startup-hook-timer ()
  (defun run-startup-idle-hooks ()
    (run-hooks 'startup-idle-hook))
  (setq startup-idle-timer
        (run-with-idle-timer
         1 nil #'run-startup-idle-hooks)))
(add-hook 'emacs-startup-hook #'setup-startup-hook-timer)
(defun m|add-idle-hook (&rest hooks)
  (dolist (x hooks)
    (add-hook 'startup-idle-hook x)))

(setq debug-on-error t)

(setq m|preload-mods '(funcs base async theming))
(m|init-mods)
(m|maybe-install-packages)

;; load configuration modules
(m|load-mods)

;; ;; i don't need a bundled custom file at all!
;; (when (and custom-file (file-exists-p custom-file))
;;   (load custom-file nil t))

(require 'server)
(unless (server-running-p)
  (server-start))
