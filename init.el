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

(setq custom-file (lqz/init-dir (if (display-graphic-p) "custom-gui.el" "custom-term.el")))
(when (file-exists-p custom-file)
  (load custom-file))


;; simple emacs version checker
(let ((minver "23.3"))
  (when (version<= emacs-version "23.1")
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))

;; add lisp load path
(add-to-list 'load-path (lqz/init-dir "lisp"))
(add-to-list 'load-path (lqz/init-dir "site-lisp"))

;; load basic init files
(require 'init-utils)
(require 'init-elpa)
(require 'init-basic)
(require 'init-frame)
(require 'init-style)

;; load specific modes and packages
(require 'init-dired)
(require 'init-undotree)
(require 'init-helm)
(require 'init-find)
(require 'init-evil)
(require 'init-guide-key)
(require 'init-htmldoc)
(require 'init-bookmark)
(require 'init-git)
(require 'init-sql)
(require 'init-projectile)
(require 'init-multi-edit)
(require 'init-workspace)
(require 'init-outline)
(require 'init-hydra)
(require 'init-indent)

(require 'init-web)
(require 'init-php)
(require 'init-python)
(require 'init-markdown)
(require 'init-org)
(require 'init-lisp)
;; minor modes which need only very little configuration
(require 'init-other-minor-mode)

(require 'init-dictionary)
(require 'init-chinese)
(require 'init-flycheck)
(require 'init-flyspell)
(require 'init-hippie-expand)
(require 'init-company)
;; for fun
(require 'init-fun)
(require 'init-emms)

;; yasnippet costs most of startup time so we load it at last.
(require 'init-yasnippet)

;; reload theme custom options
(if (boundp 'lqz/theme) (load-theme lqz/theme))

;; self-defined keymaps
(setq my-keymap-file (lqz/init-dir "my-keymap.el"))
(when (file-exists-p my-keymap-file)
  (load my-keymap-file))



(provide 'init)
