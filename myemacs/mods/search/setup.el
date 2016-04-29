(setq search-packages '(ag
                        wgrep
                        wgrep-ag
                        swiper))

(defun search/init ()
  (use-package search-utils
    :ensure nil
    :load-path (lambda () (file-name-directory #$))
    :leader ("sgi" m|search-github-code
             "sgo" m|search-google)))

(defun search/init-swiper ()
  (use-package swiper
    :bind (("M-i" . swiper))
    :config
    (m|load-relative "setup-swiper" #$)))

(defun search/init-grep ()
  (use-package grep
    :leader ("sbg" grep
             "sbG" grep-find)
    :config
    (setq grep-find-command '("find . -type f -exec grep -nHIi -P \'\' \\{\\} \\;" . 37))
    (setq grep-command "grep -nHIir -P "))

  ;; setup keys for dired mode
  (loaded dired
    (unbind-key "s" dired-mode-map)
    (bind-keys :map dired-mode-map
      ("sbg" . grep)
      ("sbG" . grep-find)))

  (use-package wgrep
    :defer t
    :config
    (setq wgrep-enable-key (kbd "C-c '"))))

(defun search/init-ag ()
  (use-package ag
    :leader ("sba" ag)
    :config
    (setq ag-arguments '("-fUi"
                         "--search-zip"
                         "--line-number"
                         "--smart-case"
                         "--nogroup"
                         "--column"
                         "--stats"
                         "--")
          ag-highlight-search t
          ag-reuse-buffers t))

  ;; setup keys for dired
  (loaded dired
    (unbind-key "s" dired-mode-map)
    (bind-keys :map dired-mode-map
      ("sba" . ag)
      ("S" . dired-sort-toggle-or-edit))))
