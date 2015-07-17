(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#ffffff" "#bf616a" "#B4EB89" "#ebcb8b" "#89AAEB" "#C189EB" "#89EBCA" "#2B303B"))
 '(auto-revert-interval 1)
 '(battery-mode-line-format "Bat: %p")
 '(battery-update-interval 10)
 '(coffee-tab-width 2)
 '(comment-style (quote extra-line))
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 2)
 '(company-quickhelp-mode nil)
 '(company-show-numbers t)
 '(custom-safe-themes
   (quote
    ("95ca92917c3104a21b0ca53aacd8a078a7f2b2dfd2fdea4a03b66b8a221379c8" "a766f853da047828950697c7a54d6767e590772d7222b0ef94db38a1edc7e67f" "eeff689a7d087484b6f17b9564f3ed2ce322365873ce7b404d57d11c45d989fc" "bbaffa6a34aa087194dad4b32d9b11fa2b3ca24e1fe569c6fa5f30c7ee969534" default)))
 '(display-battery-mode nil)
 '(fci-rule-color "#323a42")
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
    (emms helm-wgrep chinese-pyim edit-server sqlup-mode kivy-mode smex smart-tabs-mode jquery-doc workgroups2 helm-project-persist persp-mode helm-zhihu-daily ag comment-dwim-2 eide zenburn-theme youdao-dictionary yasnippet yaml-mode window-numbering wgrep-ag web-mode web-beautify vimrc-mode sr-speedbar solarized-theme smart-mode-line sass-mode real-auto-save rainbow-mode projectile-speedbar php-extras php-eldoc pcre2el outline-magic nyan-mode nginx-mode multiple-cursors markdown-mode magit lua-mode linum-relative key-chord js2-mode jade-mode info+ indent-guide iedit hydra htmlize highlight-symbol highlight-sexp highlight-parentheses highlight-chars helm-swoop helm-projectile helm-mode-manager helm-flyspell helm-flymake helm-flycheck helm-emmet helm-descbinds helm-bm helm-anything helm-ag guide-key google-translate gitignore-mode git-timemachine git-gutter flycheck-tip fish-mode firecode-theme firebelly-theme fiplr evil-surround evil-snipe evil-matchit evil-leader evil-exchange evil-args evil-anzu drag-stuff dired-rainbow dired-filter dired-efap dired-details+ dired+ cyberpunk-theme css-eldoc company-web company-statistics company-jedi color-theme-sanityinc-tomorrow coffee-mode autopair anti-zenburn-theme 2048-game)))
 '(persp-auto-resume-time 1.0)
 '(persp-filter-save-buffers-functions
   (quote
    ((lambda
       (b)
       (string-prefix-p " "
			(buffer-name b)))
     (lambda
       (b)
       (string-prefix-p "*"
			(buffer-name b)))
     (lambda
       (b)
       (stringp b)))))
 '(persp-nil-name "main")
 '(php-lineup-cascaded-calls t)
 '(projectile-known-projects-file (lqz/init-dir "tmp/projectile-bookmarks.eld"))
 '(pyim-dicts
   (quote
    ((:name "pyim-bigdict" :file "/home/qizhi/.emacs.d/dicts/pyim/pyim-bigdict.pyim" :coding utf-8-unix :dict-type pinyin-dict)
     (:name "sogou" :file "/home/qizhi/.emacs.d/dicts/pyim/sougou-phrases-full.txt" :coding utf-8-unix :dict-type pinyin-dict)
     (:name "pyim-guessdict" :file "/home/qizhi/.emacs.d/dicts/pyim/pyim-guessdict.gpyim" :coding utf-8-unix :dict-type guess-dict)
     (:name "地质大词典" :file "/home/qizhi/.emacs.d/dicts/地质大词典.pyim" :coding utf-8-unix :dict-type pinyin-dict)
     (:name "诗词名句大全" :file "/home/qizhi/.emacs.d/dicts/pyim/诗词名句大全.pyim" :coding utf-8-unix :dict-type pinyin-dict)
     (:name "搜狗颜文字表情包" :file "/home/qizhi/.emacs.d/dicts/pyim/搜狗颜文字表情包.pyim" :coding utf-8-unix :dict-type pinyin-dict)
     (:name "网络流行新词" :file "/home/qizhi/.emacs.d/dicts/pyim/网络流行新词.pyim" :coding utf-8-unix :dict-type pinyin-dict))))
 '(semantic-mode nil)
 '(session-save-file (lqz/init-dir "session/emacs.session"))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#bf616a")
     (40 . "#DCA432")
     (60 . "#ebcb8b")
     (80 . "#B4EB89")
     (100 . "#89EBCA")
     (120 . "#89AAEB")
     (140 . "#C189EB")
     (160 . "#bf616a")
     (180 . "#DCA432")
     (200 . "#ebcb8b")
     (220 . "#B4EB89")
     (240 . "#89EBCA")
     (260 . "#89AAEB")
     (280 . "#C189EB")
     (300 . "#bf616a")
     (320 . "#DCA432")
     (340 . "#ebcb8b")
     (360 . "#B4EB89"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
