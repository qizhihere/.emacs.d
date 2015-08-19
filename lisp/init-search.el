(my/install '(wgrep wgrep-ag))

(defun highlight-symbol-query-replace (symbol replacement)
  "Replace the SYMBOL with REPLACEMENT.
If no symbol given or not use a region, then the symbol at point
will be used."
  (interactive (let ((symbol (my/current-word)))
                 (highlight-symbol-temp-highlight)
                 (set query-replace-to-history-variable
                      (cons (substring-no-properties symbol)
                            (eval query-replace-to-history-variable)))
                 (list symbol
                       (read-from-minibuffer (concat "Replace 「" symbol "」 to: ") nil nil nil
                                             query-replace-to-history-variable))))
  (goto-char (beginning-of-thing 'symbol))
  (query-replace-regexp symbol replacement))

(defun my/search-github-code (keywords extension)
  "Search code in GitHub."
  (interactive
   (list
    (read-from-minibuffer "Keywords: " (my/current-word))
    (read-from-minibuffer "Extension: ")))
  (browse-url-default-browser
   (concat "https://github.com/search?type=Code&q="
           keywords "+extension:" extension)))

(defun my/search-google (keywords)
  "Search with google."
  (interactive
   (list
    (read-from-minibuffer "Keywords: " (my/current-word))))
  (browse-url-default-browser
   (concat "https://www.google.com/#q=" keywords)))

;; anzu(show search and replace info on mode line)
(my/install '(anzu ag))
(global-anzu-mode 1)
(diminish 'anzu-mode)
(defalias 'query-replace 'anzu-query-replace)
(defalias 'query-replace-regexp 'anzu-query-replace-regexp)

;; file search in current directory
(my/install 'fiplr)
(global-set-key (kbd "C-x f")	'fiplr-find-file)

;; a little simple settings
(my/install 'swiper)
(after-init (ivy-mode 1))
(after-load 'ivy
  (setq ivy-use-virtual-buffers t)
  (define-key ivy-minibuffer-map (kbd "C-o") 'ivy-recentf)
  (diminish 'ivy-mode))

(after-load 'dired
  (define-key dired-mode-map (kbd "M-i") 'swiper))

(global-set-key (kbd "M-i")	'swiper)



(provide 'init-search)
