(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ag-executable (lqz/init-dir "utils/bin/ag") t)
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(auto-revert-interval 1)
 '(battery-mode-line-format "Bat: %p")
 '(battery-update-interval 10)
 '(company-backends
   (quote
    (php-extras-company company-bbdb company-nxml company-css company-eclim company-semantic company-clang company-xcode company-cmake company-capf
                        (company-dabbrev-code company-gtags company-etags company-keywords)
                        company-oddmuse company-files company-dabbrev)))
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 2)
 '(company-show-numbers t)
 '(custom-safe-themes
   (quote
    ("b0d8a712e3a337c8f2a21923f1669119a40ee18d493fb04e1a51f2fda1f9fb6f" "05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "9558f71c706fba7b136e75d9c5e73ddd2c9d91e76e2b18f733d4ab2f388f3b72" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "a2e7b508533d46b701ad3b055e7c708323fb110b6676a8be458a758dd8f24e27" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "6a9606327ecca6e772fba6ef46137d129e6d1888dcfc65d0b9b27a7a00a4af20" "26614652a4b3515b4bbbb9828d71e206cc249b67c9142c06239ed3418eff95e2" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(display-battery-mode t)
 '(fci-rule-color "#383838")
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
 '(git-gutter:modified-sign "m")
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
 '(package-selected-packages
   (quote
    (web-beautify js2-mode htmlize undohist css-eldoc php-eldoc projectile-speedbar sr-speedbar pcre2el 2048-game color-theme-zenburn emacs-color-themes monokai-theme solarized-theme naquadah-theme alect-black-theme flatland-theme alect-themes git-timemachine hydra simpleclip window-numbering nyan-mode esup markdown-mode company company-mode info+ zenburn-theme youdao-dictionary yasnippet wgrep-ag web-mode vimrc-mode sudo-edit smart-mode-line rainbow-mode pos-tip php-extras nginx-mode multiple-cursors linum-relative key-chord indent-guide iedit highlight-symbol highlight-sexp highlight-parentheses highlight-chars helm-projectile helm-mode-manager helm-flyspell helm-flymake helm-flycheck helm-emmet helm-descbinds helm-bm helm-anything helm-ag guide-key google-translate flycheck-tip fish-mode fiplr evil-surround evil-snipe evil-nerd-commenter evil-matchit evil-leader evil-exchange evil-args evil-anzu drag-stuff dired-rainbow dired-filter dired-efap dired-details+ dired+ autopair)))
 '(php-manual-path (lqz/init-dir "manuals/php-chunked-xhtml/"))
 '(php-manual-url "http://www.php.net/manual/zh/")
 '(projectile-known-projects-file (lqz/init-dir "tmp/projectile-bookmarks.eld"))
 '(pyim-dicts
   (quote
    ((:name "sougou-phrases-full" :file "/home/qizhi/.emacs.d/dicts/pyim/sougou-phrases-full.txt" :coding utf-8-unix)
     (:name "中国历代职官" :file "/home/qizhi/.emacs.d/dicts/pyim/中国历代职官.pyim" :coding utf-8)
     (:name "地质大词典" :file "/home/qizhi/.emacs.d/dicts/pyim/地质大词典.pyim" :coding utf-8)
     (:name "搜狗颜文字表情包" :file "/home/qizhi/.emacs.d/dicts/pyim/搜狗颜文字表情包.pyim" :coding utf-8)
     (:name "新浪微博通用颜文字" :file "/home/qizhi/.emacs.d/dicts/pyim/新浪微博通用颜文字.pyim" :coding utf-8)
     (:name "网络流行新词【官方推荐】" :file "/home/qizhi/.emacs.d/dicts/pyim/网络流行新词【官方推荐】.pyim" :coding utf-8)
     (:name "诗词名句大全" :file "/home/qizhi/.emacs.d/dicts/pyim/诗词名句大全.pyim" :coding utf-8))))
 '(pyim-dicts-directory (lqz/init-dir "dicts/pyim/"))
 '(pyim-directory (lqz/init-dir "configs/pyim/"))
 '(pyim-personal-file (lqz/init-dir "dicts/pyim/pyim-personal.txt"))
 '(pyim-punctuation-dict
   (quote
    (("'" "‘" "’")
     ("\"" "“" "”")
     ("_" "――")
     ("^" "……")
     ("]" "】")
     ("[" "【")
     ("@" "◎")
     ("?" "？")
     (">" "》")
     ("=" "＝")
     ("<" "《")
     (";" "；")
     (":" "：")
     ("/" "、")
     ("." "。")
     ("-" "－")
     ("," "，")
     ("+" "＋")
     ("*" "×")
     (")" "）")
     ("(" "（")
     ("&" "※")
     ("%" "％")
     ("$" "￥")
     ("#" "＃")
     ("!" "！")
     ("`" "・")
     ("~" "～")
     ("}" "』")
     ("|" "÷")
     ("{" "『")
     ("\\" "、"))))
 '(safe-local-variable-values
   (quote
    ((no-byte-compile t)
     (eval when
           (require
            (quote rainbow-mode)
            nil t)
           (rainbow-mode 1)))))
 '(session-save-file (lqz/init-dir "session/emacs.session"))
 '(sml/battery-format " %p%%")
 '(sml/mode-width (quote 20))
 '(sml/prefix-face-list
   (quote
    (("\\[.*]" sml/projectile)
     (":SU:" sml/sudo)
     (":G" sml/git)
     ("" sml/prefix))))
 '(sml/prefix-regexp (quote ("\\[.*]" ":\\(.*:\\)" "~/")))
 '(sml/projectile-replacement-format "[%s]")
 '(sml/size-indication-format " %I ")
 '(undohist-directory "/home/qizhi/.emacs.d/tmp/undohist")
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(window-numbering-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-errline ((t (:background "color-88" :foreground "yellow" :underline (:color foreground-color :style wave) :weight bold))))
 '(git-gutter:added ((t (:background "green" :foreground "#383838" :inverse-video t :weight bold))))
 '(git-gutter:deleted ((t (:background "red" :foreground "#383838" :inverse-video t :weight bold))))
 '(git-gutter:modified ((t (:background "yellow" :foreground "#383838" :inverse-video t :weight bold))))
 '(git-gutter:unchanged ((t (:foreground "#DCDCCC" :inverse-video t :weight bold))))
 '(hc-trailing-whitespace ((t (:background "HotPink"))))
 '(window-numbering-face ((t nil)) t))
