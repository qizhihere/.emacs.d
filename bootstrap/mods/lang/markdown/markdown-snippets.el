(let* ((s #'markdown-insert-gfm-code-block)
       (orange `(:foreground "orange" :weight bold))
       (green `(:foreground "green" :weight bold))
       (brick `(:foreground "#e52b50"))
       (brown `(:foreground "#6d402d"))
       )

  (cl-flet* ((colorize (x st) (propertize x 'face st))
             (s+ (&rest *) (reduce #'concat *))
             (+s (x) (colorize x orange))
             (+b (x) (colorize x green))
             (+r (x) (colorize x brick))
             (+o (x) (colorize x brown))
             (~s (x) `(,(concat (+s "src: ") x) (,s ,x))))

    (setq markdown-snippets
          `(
            ;; source code blocks
            ,(+s "src")
            ,(~s "c")
            ,(~s "coffee")
            ,(~s "c++")
            ,(~s "css")
            ,(~s "emacs-lisp")
            ,(~s "html")
            ,(~s "java")
            ,(~s "javascript")
            ,(~s "less")
            ,(~s "lisp")
            ,(~s "lua")
            ,(~s "nginx")
            ,(~s "org")
            ,(~s "php")
            ,(~s "python")
            ,(~s "sass")
            ,(~s "sh")
            ,(~s "sql")

            ;; other blocks
            (,(+b "quote") markdown-insert-blockquote)
            (,(+b "hr") markdown-insert-hr)

            ;; attr fields
            "title: "
            "author: "

            ;; other snippets
            ("image" markdown-insert-image)
            ("invisible space" "\u200B")
            ("footnote" markdown-insert-footnote)
            ("timestamp" (insert (concat "<" (format-time-string "%Y-%m-%d %b %H:%M") ">")))
            ("timestamp(calendar)" (call-interactively 'org-time-stamp))
            ))))

(defun markdown-insert-snippet ()
  (interactive)
  (simple-complete markdown-snippets "Select a snippet: "))

(defun markdown-M-RET-dwim ()
  (interactive)
  (if (markdown-cur-list-item-bounds)
      (call-interactively 'markdown-insert-list-item)
    (call-interactively 'markdown-insert-header-dwim)))



(provide 'markdown-snippets)
