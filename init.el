;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

;; comment out the below line because i will run it in lisp/init-elpa.el,
;; to prevent emacs automatically add things to here, don't delete the line.
;; (package-initialize)

(defconst *is-gui* (if (getenv "EMACS_NO_GUI") nil window-system))
;; (defconst *use-session* t)
(defconst *startup-silently* t)
(defconst *start-at-time* (float-time))

(defun my/init-dir (path)
  "Return the absolute path of subdirectory in dotemacs."
  (expand-file-name path user-emacs-directory))

;; if a different emacs init dir provided then use it
(setq user-emacs-directory (or (getenv "EMACS_INIT_DIR")
                               user-emacs-directory))

;; add lisp load path
(dolist (x (list (my/init-dir "lisp") (my/init-dir "site-lisp")))
  (add-to-list 'load-path x))

(setq custom-file (my/init-dir (if *is-gui* "custom-gui.el" "custom-term.el")))

(require 'init-elpa)
(require 'init-utils)

;; use bug-hunter for debug purpose
;; more info see https://github.com/Malabarba/elisp-bug-hunter/
;; (my/install 'bug-hunter)
(my/install 'diminish)

(require 'init-basic)
(require 'init-edit)

(require 'init-frame)
(require 'init-style)
(require 'init-mode-line)
(require 'init-ansi-term)

(require 'init-dired)
(require 'init-helm)
(require 'init-search)
(require 'init-ido)
(require 'init-undotree)
(require 'init-evil)
;; (require 'init-htmldoc)
(require 'init-git)
(require 'init-hydra)
(require 'init-guide-key)
(require 'init-session)

(require 'init-dictionary)
(require 'init-flycheck)
(require 'init-flyspell)
(require 'init-hippie-expand)
(require 'init-company)
(require 'init-yasnippet)

(require 'init-html)
(require 'init-css)
(require 'init-javascript)
(require 'init-php)
(require 'init-python)
(require 'init-markdown)
(require 'init-sql)
(require 'init-org)
(require 'init-pdf)
(require 'init-lisp)
;; ;; minor modes which need only very little configuration
(require 'init-small-minor-modes)


(when (file-exists-p custom-file)
  (load custom-file))

(require 'server)
(unless (server-running-p)
  (server-start))

;; self-defined keymaps
(setq my-keymap-file (my/init-dir "keybindings.el"))
(when (file-exists-p my-keymap-file)
  (load my-keymap-file))



(provide 'init)
