;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.


;; simple emacs version checker

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(let ((minver "23.3"))
  (when (version<= emacs-version "23.1")
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))


(defun lqz/init-dir (path)
  "simply return absolute path of subdirectory reference to ~/.emacs.d "
  (expand-file-name path user-emacs-directory))


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

(require 'init-html)
(require 'init-css)
(require 'init-php)
(require 'init-markdown)
(require 'init-org)
(require 'init-lisp)
(require 'init-other-minor-mode)

(require 'init-flycheck)
(require 'init-dictionary)

;; yasnippet costs most of startup time so we load it at last.
(require 'init-yasnippet)

;; Variables configured via the interactive 'customize' interface
(setq custom-file (lqz/init-dir "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))



(provide 'init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-ag-base-command
   (concat
    (lqz/init-dir "utils/bin/ag")
    " --nocolor --nogroup --ignore-case"))
 '(helm-ag-command-option "--all-text")
 '(helm-ag-insert-at-point (quote symbol))
 '(package-selected-packages
   (quote
    (gitignore-mode magit zenburn-theme youdao-dictionary yasnippet window-numbering wgrep-ag web-mode vimrc-mode sudo-edit smart-mode-line simpleclip rainbow-mode pos-tip php-extras nginx-mode multiple-cursors linum-relative key-chord info+ indent-guide iedit highlight-symbol highlight-sexp highlight-parentheses highlight-chars helm-projectile helm-mode-manager helm-flyspell helm-flymake helm-flycheck helm-emmet helm-descbinds helm-bm helm-anything helm-ag guide-key google-translate flycheck-tip fish-mode fiplr evil-surround evil-snipe evil-nerd-commenter evil-matchit evil-leader evil-exchange evil-args evil-anzu drag-stuff dired-rainbow dired-filter dired-efap dired-details+ dired+ autopair))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
