(lqz/require
 '(
   helm
   helm-ag
   helm-anything
   helm-bm
   helm-descbinds
   helm-emmet
   helm-flymake
   helm-flycheck
   helm-flyspell
   helm-mode-manager
   helm-projectile
   ))


(require 'helm-config)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq	  helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
	  helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
	  helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
	  helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
	  helm-ff-file-name-history-use-recentf t
	  helm-move-to-line-cycle-in-source     nil

	  helm-buffers-fuzzy-matching t
	  helm-semantic-fuzzy-match   t
	  helm-imenu-fuzzy-match      t
	  helm-M-x-fuzzy-match        t
	  helm-apropos-fuzzy-match    t
	  helm-lisp-fuzzy-completion  t
	  helm-recentf-fuzzy-match    t)

(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

(helm-mode 1)
(helm-autoresize-mode t)
(helm-descbinds-mode)


;;--------------
;; helm-ag
;;--------------
(custom-set-variables
 '(helm-ag-base-command (concat (lqz/init-dir "utils/bin/ag") " --nocolor --nogroup --ignore-case"))
 '(helm-ag-command-option "--all-text")
 '(helm-ag-insert-at-point 'symbol))


;;---------------------------------
;; keybinds
;;---------------------------------
;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "C-i")	'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z")	'helm-select-action) ; list actions using C-z

(global-set-key (kbd "M-x")		'helm-M-x)
(global-set-key (kbd "M-y")		'helm-show-kill-ring)
(global-set-key (kbd "C-x b")		'helm-mini)
(global-set-key (kbd "C-x C-f")		'helm-find-files)
(global-set-key (kbd "C-c h o")		'helm-occur)
(global-set-key (kbd "C-h SPC")		'helm-all-mark-rings)
(global-set-key (kbd "C-c h x")		'helm-register)
(global-set-key (kbd "C-c h g")		'helm-google-suggest)
(global-set-key (kbd "C-c h M-l")	'helm-eval-expression-with-eldoc)
(define-key minibuffer-local-map (kbd "C-c C-l") 'helm-minibuffer-history)


;;--------------
;; smex
;;--------------
;; (lqz/require 'smex)
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)



(provide 'init-helm)
