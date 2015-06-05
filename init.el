;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

;; comment out the below line because i will run it in lisp/init-elpa.el,
;; to prevent emacs automatically add things to here, don't delete the line.
;; (package-initialize)

;; use esup to analysize startup time, current not used
;; (add-to-list 'load-path "~/.emacs.d/elpa/esup-20150519.1701")
;; (autoload 'esup "esup" "Emacs Start Up Profiler." nil)

(defun lqz/init-dir (path)
  "simply return absolute path of subdirectory reference to ~/.emacs.d "
  (expand-file-name path user-emacs-directory))

(setq custom-file (lqz/init-dir "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))


;; simple emacs version checker
(let ((minver "23.3"))
  (when (version<= emacs-version "23.1")
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))

;; add lisp load path
(add-to-list 'load-path (lqz/init-dir "lisp"))

;; load basic init files
(require 'init-utils)
(require 'init-elpa)
(require 'init-basic)
(require 'init-style)
(require 'init-frame)

;; load specific modes and packages
(require 'init-dired)
(require 'init-speedbar)
(require 'init-undotree)
(require 'init-helm)
(require 'init-find)
(require 'init-evil)
(require 'init-guide-key)
(require 'init-htmldoc)
(require 'init-bookmark)
(require 'init-git)
(require 'init-projectile)
(require 'init-multi-edit)
(require 'init-window-control)
(require 'init-hydra)

(require 'init-web)
(require 'init-php)
(require 'init-markdown)
(require 'init-org)
(require 'init-lisp)
(require 'init-fun)
;; minor modes which need only very little configuration
(require 'init-other-minor-mode)

(require 'init-dictionary)
(require 'init-input-method)
(require 'init-flycheck)
(require 'init-flyspell)
(require 'init-company)


;; yasnippet costs most of startup time so we load it at last.
(require 'init-yasnippet)

;; self-defined keymaps
(setq my-keymap-file (lqz/init-dir "my-keymap.el"))
(when (file-exists-p my-keymap-file)
  (load my-keymap-file))



(provide 'init)
