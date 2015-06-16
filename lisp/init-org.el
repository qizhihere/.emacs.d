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

(setq org-babel-python-command "python2")


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


;; export settings
(setq org-publish-project-alist
      '(
        ("org-notes"
         :author "littleqz"
         :email "qizhihere@gmail.com"
         :base-directory "~/org"
         :base-extension "org"
         :html-extension "html"
         :publishing-directory "~/sync/Dropbox/public/blog"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :section-numbers nil
         :html-postamble nil
         )
        ("org-static"
         :base-directory "~/org"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|mp4\\|ogg\\|swf"
         :publishing-directory "~/sync/Dropbox/public/blog"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("org" :components ("org-notes" "org-static"))))



(provide 'init-org)
