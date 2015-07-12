(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ag-executable (lqz/init-dir "utils/bin/ag") t)
 '(ansi-color-names-vector
   (vector "#ffffff" "#bf616a" "#B4EB89" "#ebcb8b" "#89AAEB" "#C189EB" "#89EBCA" "#232830"))
 '(auto-revert-interval 1)
 '(battery-mode-line-format "Bat: %p")
 '(battery-update-interval 10)
 '(coffee-tab-width 2)
 '(comment-style (quote extra-line))
 '(company-backends
   (quote
    (php-extras-company company-bbdb company-nxml company-css company-eclim company-semantic company-clang company-xcode company-cmake company-capf
                        (company-dabbrev-code company-gtags company-etags company-keywords)
                        company-oddmuse company-files company-dabbrev)))
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 2)
 '(company-quickhelp-mode t)
 '(company-show-numbers t)
 '(custom-safe-themes
   (quote
    ("e49a2d95edd6d58e4f6a0706bef0928bdb6cd03a9a68f302b86759f8a139732d" "8f2e60e25bd33a29f45867d99c49afd9d7f3f3ed8a60926d32d5a23c790de240" "4ff23437b3166eeb7ca9fa026b2b030bba7c0dfdc1ff94df14dfb1bcaee56c78" "90edd91338ebfdfcd52ecd4025f1c7f731aced4c9c49ed28cfbebb3a3654840b" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "46fd293ff6e2f6b74a5edf1063c32f2a758ec24a5f63d13b07a20255c074d399" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "7bde52fdac7ac54d00f3d4c559f2f7aa899311655e7eb20ec5491f3b5c533fe8" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "b06aaf5cefc4043ba018ca497a9414141341cb5a2152db84a9a80020d35644d1" "9122dfb203945f6e84b0de66d11a97de6c9edf28b3b5db772472e4beccc6b3c5" "18a33cdb764e4baf99b23dcd5abdbf1249670d412c6d3a8092ae1a7b211613d5" "ba9be9caf9aa91eb34cf11ad9e8c61e54db68d2d474f99a52ba7e87097fa27f5" "726dd9a188747664fbbff1cd9ab3c29a3f690a7b861f6e6a1c64462b64b306de" "1db337246ebc9c083be0d728f8d20913a0f46edc0a00277746ba411c149d7fe5" "ffe39e540469ef05808ab4b75055cc81266875fa4a0d9e89c2fec1da7a6354f3" "c006bc787154c31d5c75e93a54657b4421e0b1a62516644bd25d954239bc9933" "ad24ea739f229477ea348af968634cb7a0748c9015110a777c8effeddfa920f5" "b0d8a712e3a337c8f2a21923f1669119a40ee18d493fb04e1a51f2fda1f9fb6f" "05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "9558f71c706fba7b136e75d9c5e73ddd2c9d91e76e2b18f733d4ab2f388f3b72" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "a2e7b508533d46b701ad3b055e7c708323fb110b6676a8be458a758dd8f24e27" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "6a9606327ecca6e772fba6ef46137d129e6d1888dcfc65d0b9b27a7a00a4af20" "26614652a4b3515b4bbbb9828d71e206cc249b67c9142c06239ed3418eff95e2" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(display-battery-mode t)
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
    (anti-zenburn-theme spacegray-theme cyberpunk-theme color-theme-sanityinc-tomorrow firebelly-theme firecode-theme company-jedi company-quickhelp company-statistics company-web outline-magic sass-mode coffee-mode chinese-pyim yaml-mode jade-mode git-gutter gitignore-mode magit helm-swoop real-auto-save lua-mode web-beautify js2-mode htmlize undohist css-eldoc php-eldoc projectile-speedbar sr-speedbar pcre2el 2048-game color-theme-zenburn emacs-color-themes monokai-theme solarized-theme naquadah-theme alect-black-theme flatland-theme alect-themes git-timemachine hydra simpleclip window-numbering nyan-mode esup markdown-mode company company-mode info+ zenburn-theme youdao-dictionary yasnippet wgrep-ag web-mode vimrc-mode sudo-edit smart-mode-line rainbow-mode pos-tip php-extras nginx-mode multiple-cursors linum-relative key-chord indent-guide iedit highlight-symbol highlight-sexp highlight-parentheses highlight-chars helm-projectile helm-mode-manager helm-flyspell helm-flymake helm-flycheck helm-emmet helm-descbinds helm-bm helm-anything helm-ag guide-key google-translate flycheck-tip fish-mode fiplr evil-surround evil-snipe evil-nerd-commenter evil-matchit evil-leader evil-exchange evil-args evil-anzu drag-stuff dired-rainbow dired-filter dired-efap dired-details+ dired+ autopair)))
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
 '(undo-tree-incompatible-major-modes (quote (term-mode\ magit-status-mode)))
 '(undohist-directory "/home/qizhi/.emacs.d/tmp/undohist")
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
 '(vc-annotate-very-old-color nil)
 '(window-numbering-mode t))
