(lqz/require '(org htmlize))

(setq org-support-shift-select   nil
      org-catch-invisible-edits 'org
      org-html-footnote-format  "<sup>%s</sup>"
      error-footnote-define-inline t
      org-src-fontify-natively   t
      org-startup-align-all-tables t
      org-footnote-auto-label   'random
      org-footnote-auto-adjust  nil
      org-export-with-sub-superscripts '{}
      org-odt-preferred-output-format  "pdf"
      org-html-htmlize-output-type 'css
      org-todo-keywords		'((sequence "TODO(t)" "|" "DOING" "DELAY" "DONE(d)" "CANCEL(c)"))
      org-todo-keyword-faces    '(("DELAY" . "orange") ("CANCEL" . "gray"))
      org-tag-alist		'(
                  ("@笔记" . ?n) ("@感悟" . ?m)  ("@经验" . ?x) ("@教程" . ?u)
                  ("@转载" . ?p) ("@翻译" . ?t)
                  (:startgroup . nil)
                  ("linux" . ?l) ("数据库" . ?d) ("php" . ?h) ("python" . ?y)
                  ("ruby" . ?r)  ("emacs" . ?e)  ("vim" . ?v)
                  (:endgroup . nil)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh     . t)
   (python . t)
   (R      . t)
   (ruby   . t)
   (ditaa  . t)
   (dot    . t)
   (octave . t)
   (sqlite . t)
   (perl   . t)
   (C      . t)
   ))

(setq org-babel-python-command "python2"
      org-babel-sh-command     "bash")


(defun lqz/org-mode-hook ()
  (setq truncate-lines nil)
  (define-key org-mode-map (kbd "C-c e") 'org-edit-src-code))

(add-hook 'org-mode-hook     'lqz/org-mode-hook)
(add-hook 'message-mode-hook 'turn-on-orgtbl)
(add-hook 'text-mode-hook    'turn-on-orgtbl)
(add-hook 'mail-mode-hook    'turn-on-orgtbl)

;; fix org html export bug
(defun org-font-lock-ensure ()
  (font-lock-fontify-buffer))

;; set blog page header and footer html raw string
(setq org-html-preamble-format (list (list "en" (get-string-from-file "~/org/layouts/header.org"))))
(setq org-html-postamble-format (list (list "en" (get-string-from-file "~/org/layouts/footer.org"))))

(defun lqz/new-note (file)
  "create a new note in ~/sync/Dropbox/writing/posts."
  (interactive "sPlease input the note file name: ")
  (find-file (concat "~/org/posts/" file))
  (lqz/send-keys "M-o iHE"))

(defun lqz/open-note ()
  "open a note in ~/sync/Dropbox/writing/posts."
  (interactive)
  (find-file (read-file-name "Select a note: " "~/org/posts/")))

(defun lqz/org-update-index (&rest x)
  (interactive)
  (shell-command "touch ~/org/posts/post-list.org")
  (shell-command "touch ~/org/index.org")
  (shell-command "touch ~/org/sitemap.org"))

(defun lqz/current-timestamp ()
  "insert current timestamp."
  (interactive)
  (insert (format-time-string "%Y-%m-%d %b %H:%M:%S")))

;; export settings
(setq org-publish-project-alist
      '(
        ("notes"
         :author "littleqz"
         :auto-sitemap t                  ; Generate sitemap.org automagically...
         :base-directory "~/org/posts"
         :base-extension "org"
         :email "qizhihere@gmail.com"
         :exclude "footer.org\\|header.org\\|blog.setup\\|sitemap.org\\|.*draft.org"
         :headline-levels 4               ; Just the default for this project.
         :html-extension "html"
         :html-postamble t
         :html-preamble t
         :publishing-directory "~/sync/Dropbox/public/blog/html"
         :publishing-function org-html-publish-to-html
         :recursive t
         :section-numbers nil
         :sitemap-date-format "%Y.%m.%d"
         :sitemap-file-entry-format "%d » %t"
         :sitemap-filename "post-list.org"  ; ... call it sitemap.org (it's the default)...
         :sitemap-sort-files anti-chronologically  ; sort file time reversely
         :sitemap-sort-folders last
         :sitemap-title " "         ; ... with title 'Sitemap'.
         )
        ("meta"
         :base-directory "~/org"
         :base-extension "org"
         :html-extension "html"
         :publishing-directory "~/sync/Dropbox/public/blog/html"
         :recursive nil
         :publishing-function (lqz/org-update-index org-html-publish-to-html)
         :html-postamble t
         :html-preamble t
         )
        ("static"
         :base-directory "~/org"
         :base-extension "ico\\|css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|mp4\\|ogg\\|swf"
         :publishing-directory "~/sync/Dropbox/public/blog/html"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("blog" :components ("notes" "static" "meta"))))



(provide 'init-org)
