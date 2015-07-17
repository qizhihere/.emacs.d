(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-revert-interval 1)
 '(battery-mode-line-format "Bat: %p")
 '(battery-update-interval 10)
 '(coffee-tab-width 2)
 '(comment-style (quote extra-line))
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 2)
 '(company-quickhelp-mode t)
 '(company-show-numbers t)
 '(custom-safe-themes
   (quote
    ("b06aaf5cefc4043ba018ca497a9414141341cb5a2152db84a9a80020d35644d1" default)))
 '(display-battery-mode t)
 '(fiplr-ignored-globs
   (quote
    ((directories
      (".git" ".svn" ".hg" ".bzr" "vendor"))
     (files
      (".#*" "*~" "*.so" "*.jpg" "*.png" "*.gif" "*.pdf" "*.gz" "*.zip")))))
 '(fiplr-root-markers (quote (".git" ".svn" ".hg" ".bzr" "composer.json")))
 '(flymake-fringe-indicator-position (quote right-fringe))
 '(git-gutter:added-sign "+")
 '(git-gutter:deleted-sign "-")
 '(git-gutter:modified-sign "~")
 '(git-gutter:update-interval 1)
 '(global-company-mode t)
 '(helm-M-x-always-save-history t)
 '(helm-ag-base-command
   (concat
    (lqz/init-dir "utils/bin/ag")
    " --nocolor --nogroup --ignore-case"))
 '(helm-ag-command-option "--all-text")
 '(helm-ag-insert-at-point (quote symbol))
 '(helm-dash-docsets-path (lqz/init-dir "docs") t)
 '(helm-ff-auto-update-initial-value nil)
 '(helm-file-cache-fuzzy-match t)
 '(highlight-symbol-idle-delay 0.5)
 '(highlight-symbol-on-navigation-p t)
 '(highlight-symbol-print-occurrence-count (quote explicit))
 '(js-indent-level 2)
 '(nyan-bar-length 20)
 '(nyan-cat-face-number 3)
 '(nyan-mode t)
 '(nyan-wavy-trail nil)
 '(org-startup-indented t)
 '(package-selected-packages
   (quote
    (zenburn-theme youdao-dictionary yasnippet yaml-mode window-numbering wgrep-ag web-mode web-beautify vimrc-mode sr-speedbar solarized-theme smart-mode-line sass-mode real-auto-save rainbow-mode projectile-speedbar project-explorer php-extras php-eldoc pcre2el outline-magic nyan-mode nginx-mode multiple-cursors markdown-mode magit lua-mode linum-relative key-chord js2-mode jade-mode info+ indent-guide iedit hydra htmlize highlight-symbol highlight-sexp highlight-parentheses highlight-chars helm-swoop helm-projectile helm-mode-manager helm-flyspell helm-flymake helm-flycheck helm-emmet helm-descbinds helm-bm helm-anything helm-ag guide-key google-translate gitignore-mode git-timemachine git-gutter flycheck-tip fish-mode firecode-theme firebelly-theme fiplr evil-surround evil-snipe evil-nerd-commenter evil-matchit evil-leader evil-exchange evil-args evil-anzu drag-stuff dired-rainbow dired-filter dired-efap dired-details+ dired+ cyberpunk-theme css-eldoc company-web company-statistics company-quickhelp company-jedi color-theme-sanityinc-tomorrow coffee-mode autopair anti-zenburn-theme 2048-game)))
 '(projectile-known-projects-file (lqz/init-dir "tmp/projectile-bookmarks.eld"))
 '(session-save-file (lqz/init-dir "session/emacs.session")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-overstrike ((t (:inherit bold :foreground "color-202"))))
 '(Man-reverse ((t (:inherit highlight :background "color-38" :foreground "color-231"))))
 '(Man-underline ((t (:inherit underline :foreground "color-41"))))
 '(flymake-errline ((t (:background "color-88" :foreground "yellow" :underline (:color foreground-color :style wave) :weight bold))))
 '(git-gutter:added ((t (:background "green" :foreground "#3a3a3a" :inverse-video t :weight bold))))
 '(git-gutter:deleted ((t (:background "red" :foreground "#3a3a3a" :inverse-video t :weight bold))))
 '(git-gutter:modified ((t (:background "yellow" :foreground "#3a3a3a" :inverse-video t :weight bold))))
 '(git-gutter:unchanged ((t (:foreground "#3a3a3a" :inverse-video t :weight bold)))))
