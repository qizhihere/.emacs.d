(let* ((~ #'org-expand)
       (s #'org-insert-src)
       (b #'org-insert-block)
       (orange `(:foreground "orange" :weight bold))
       (green `(:foreground "green" :weight bold))
       (brick `(:foreground "#e52b50"))
       (brown `(:foreground "#6d402d"))
       )

  (cl-flet* ((colorize (x st) (propertize x 'face st))
             (~~ (x) `(,~ ,x))
             (s+ (&rest *) (reduce #'concat *))
             (+s (x) (colorize x orange))
             (+b (x) (colorize x green))
             (+r (x) (colorize x brick))
             (+o (x) (colorize x brown))
             (~s (x) `(,(concat (+s "src: ") x) (,s ,x)))
             (~b (x k) `(,(+b (concat "#+begin_" x))
                         ,(if (stringp k) `(,~ ,k) `(lambda () ,k)))))

    (setq org-snippets
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
            ,(~b "center" "<c")
            ,(~b "comment" `(,b "comment"))
            ,(~b "example" "<e")
            ,(~b "html" "<h")
            ,(~b "quote" "<q")
            ,(~b "verse" "<v")
            (,(+b "drawer") org-insert-drawer)

            ;; attr fields
            ("#+include: " ,(~~ "<I"))
            ("#+index: " ,(~~ "<i"))
            "#+author: "
            "#+caption: "
            "#+macro: "
            "#+name: "
            "#+options: ^:{} toc:2"
            "#+startup: "
            "#+title: "

            ;; other snippets
            ("latex" ,(~~ "<L"))
            ("image" org-insert-image)
            ("invisible space" "\u200B")
            ("footnote" org-footnote-action)
            ("inline footnote" (progn (insert (concat "[fn::]")) (backward-char)))
            ("timestamp" (insert (concat "<" (format-time-string "%Y-%m-%d %b %H:%M") ">")))
            ("timestamp(from cal)" (call-interactively 'org-time-stamp))
            (,(s+ (+r "[X]") " checkbox") (progn (org-meta-return) (insert "[ ] ")))
            (,(s+ "* " (+r "TODO")) (call-interactively #'org-insert-todo-heading))
            ))))

(defun org-insert-snippet ()
  (interactive)
  (simple-complete org-snippets "Select a snippet: "))

(defun org-expand(str)
  "Expand org template."
  (insert str)
  (org-try-structure-completion))

(defun org-insert-src (&optional lang)
  "Quickly insert src block in org-mode."
  (org-expand "<s")
  (if lang (insert lang) (delete-char -1))
  (next-line))

(defun org-insert-block (name)
  "Quickly insert block in org-mode."
  (insert (format "#+begin_%s\n\n#+end_%s" name name))
  (previous-line))

(defun org-insert-image ()
  (let ((file (file-relative-name
               (read-file-name "Select an image:"
                               (bound-and-true-p org-last-image-dir) nil t)
               default-directory)))
    (setq org-last-image-dir (file-name-directory file))
    (insert (concat "[[" file "]]"))))



(provide 'org-snippets)
