(add-to-list 'load-path (expand-file-name "core" m|conf))

(require 'cl)
(require 'core-vars)
(require 'core-helpers)
(require 'core-command-line)
(require 'core-mods)
(require 'core-elpa)
(require 'core-startup-hook)
(with-eval-after-load 'use-package
  (require 'core-use-package-ext))

(m|add-path (m|conf "bin"))
(setq auto-save-list-file-prefix nil)

;; ensure use-package is installed
(m|maybe-install-packages '(use-package))

;; reset `gc-cons-threshold'
(m|add-startup-hook (lambda () (setq gc-cons-threshold 20000000)))

(setq m|preload-mods '(funcs base async theming))
(m|init-mods)
(m|maybe-install-packages)

;; load configuration modules
(m|load-mods)

(require 'server)
(unless (server-running-p)
  (server-start))
