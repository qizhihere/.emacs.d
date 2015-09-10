;;----------------------------------------------------------------------------
;; helm basic config
;;----------------------------------------------------------------------------
(my/install 'helm)
(require 'helm-config)
(setq helm-split-window-in-side-p           nil ; open helm buffer inside current window, not occupy whole other window
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



;;----------------------------------------------------------------------------
;; helm projectile
;;----------------------------------------------------------------------------
(my/install 'helm-projectile)
(add-hook 'prog-mode-hook 'projectile-mode)
(after-load 'projectile
  (diminish 'projectile-mode)
  (setq projectile-completion-system 'helm
        projectile-enable-caching t
        projectile-cache-file (my/init-dir "tmp/projectile.cache")
        projectile-known-projects-file (my/init-dir "tmp/projectile-bookmarks.eld"))
  (add-to-list 'projectile-globally-ignored-directories "vendor"))


(after-init (helm-mode 1))


(after-load 'helm-mode
  (diminish 'helm-mode)
  (my/require 'helm-descbinds)
  (silently-do
   (helm-descbinds-mode)
   (helm-autoresize-mode t)
   (helm-projectile-on))

  (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") 'helm-select-action)
  (global-set-key (kbd "C-c h") 'helm-command-prefix)

  (global-set-key (kbd "C-x C-b")  'helm-mini)
  (global-set-key (kbd "C-x C-f")  'helm-find-files)
  (global-set-key (kbd "C-c h o")  'helm-occur)
  (global-set-key (kbd "C-c h x")  'helm-register)
  (global-set-key (kbd "M-y")      'helm-show-kill-ring))

;; disable evil-mode in helm buffers
(when (fboundp 'turn-off-evil-mode)
  (add-hook 'helm--minor-mode-hook 'turn-off-evil-mode))



;;----------------------------------------------------------------------------
;; helm-ag
;;----------------------------------------------------------------------------
(my/install 'helm-ag)
(custom-set-variables
 '(helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
 '(helm-ag-command-option "--all-text")
 '(helm-ag-insert-at-point 'symbol))


;;----------------------------------------------------------------------------
;; helm-org
;;----------------------------------------------------------------------------
(after-load 'org
  (define-key org-mode-map (kbd "C-c l") 'helm-org-in-buffer-headings))



(provide 'init-helm)
