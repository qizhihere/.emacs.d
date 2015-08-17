(my/install '(org htmlize pangu-spacing))

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

(after-load 'org
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
	 (C      . t)))

  (setq org-babel-python-command "python2"
		org-babel-sh-command     "bash"))

(add-hook 'message-mode-hook 'turn-on-orgtbl)
(add-hook 'text-mode-hook    'turn-on-orgtbl)
(add-hook 'mail-mode-hook    'turn-on-orgtbl)

;; fix org html export bug
(defun org-font-lock-ensure ()
  (font-lock-fontify-buffer))

;; set blog page header and footer html raw string
(setq org-html-preamble-format (list (list "en" (cat "~/org/layouts/header.org"))))
(setq org-html-postamble-format (list (list "en" (cat "~/org/layouts/footer.org"))))

(defun my/new-note (file)
  "create a new note in ~/sync/Dropbox/writing/posts."
  (interactive "sPlease input the note file name: ")
  (find-file (concat "~/org/posts/" file))
  (my/send-keys "M-o iHE"))

(defun my/open-note ()
  "open a note in ~/sync/Dropbox/writing/posts."
  (interactive)
  (find-file (read-file-name "Select a note: " "~/org/posts/")))

(defun my/org-update-index (&rest x)
  (interactive)
  (shell-command "touch ~/org/posts/post-list.org")
  (shell-command "touch ~/org/index.org")
  (shell-command "touch ~/org/sitemap.org"))

(defun my/current-timestamp ()
  "insert current timestamp."
  (interactive)
  (insert (format-time-string "%Y-%m-%d %b %H:%M:%S")))

(defun my/custom-org-html-funcs ()
  (defun org-html-template (contents info)
	"Return complete document string after HTML conversion.
CONTENTS is the transcoded contents string.  INFO is a plist
holding export options."
	(concat
	 (when (and (not (org-html-html5-p info)) (org-html-xhtml-p info))
	   (let ((decl (or (and (stringp org-html-xml-declaration)
							org-html-xml-declaration)
					   (cdr (assoc (plist-get info :html-extension)
								   org-html-xml-declaration))
					   (cdr (assoc "html" org-html-xml-declaration))

					   "")))
		 (when (not (or (eq nil decl) (string= "" decl)))
		   (format "%s\n"
				   (format decl
						   (or (and org-html-coding-system
									(fboundp 'coding-system-get)
									(coding-system-get org-html-coding-system 'mime-charset))
							   "iso-8859-1"))))))
	 (org-html-doctype info)
	 "\n"
	 (concat "<html"
			 (when (org-html-xhtml-p info)
			   (format
				" xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"%s\" xml:lang=\"%s\""
				(plist-get info :language) (plist-get info :language)))
			 ">\n")
	 "<head>\n"
	 (org-html--build-meta-info info)
	 (org-html--build-head info)
	 (org-html--build-mathjax-config info)
	 "</head>\n"
	 "<body class=\"ui grid\">\n"
	 "<div id=\"container\" class=\"eleven wide computer fifteen wide tablet mobile centered column\">"
	 (let ((link-up (org-trim (plist-get info :html-link-up)))
		   (link-home (org-trim (plist-get info :html-link-home))))
	   (unless (and (string= link-up "") (string= link-home ""))
		 (format org-html-home/up-format
				 (or link-up link-home)
				 (or link-home link-up))))
	 ;; Preamble.
	 (org-html--build-pre/postamble 'preamble info)
	 ;; Document contents.
	 (format "<%s id=\"%s\">\n"
			 (nth 1 (assq 'content org-html-divs))
			 (nth 2 (assq 'content org-html-divs)))
	 ;; Document title.
	 (let ((title (plist-get info :title)))
	   (format "<h1 class=\"title\">%s</h1>\n" (org-export-data (or title "") info)))
	 contents
	 (format "</%s>\n"
			 (nth 1 (assq 'content org-html-divs)))
	 ;; Postamble.
	 (org-html--build-pre/postamble 'postamble info)
	 ;; Closing document.
	 "</div>"
	 "</body>\n</html>")))

(add-hook 'org-mode-hook
		  (lambda ()
			(my/custom-org-html-funcs)
			(pangu-spacing-mode 1)
			(setq truncate-lines nil)
			(linum-mode -1)))

;; export settings
(setq org-publish-project-alist
	  '(("notes"
		 :author "littleqz"
		 :auto-sitemap t                  ; Generate sitemap.org automagically...
		 :base-directory "~/org/posts"
		 :base-extension "org"
		 :email "qizhihere@gmail.com"
		 :exclude "footer.org\\|header.org\\|blog.setup\\|sitemap.org\\|.*draft.org"
		 :headline-levels 4               ; Just the default for this project.
		 :html-extension "html"
		 :html-link-home "/"
		 :html-link-up "/"
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
		 :exclude "node_modules\\|gulpfile.js"
		 :publishing-directory "~/sync/Dropbox/public/blog/html"
		 :recursive nil
		 :publishing-function (my/org-update-index org-html-publish-to-html)
		 :html-postamble t
		 :html-preamble t
		 )
		("static"
		 :base-directory "~/org"
		 :exclude "node_modules\\|gulpfile.js"
		 :base-extension "ico\\|css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|mp4\\|ogg\\|swf\\|eot\\|svg\\|ttf\\|woff\\|woff2"
		 :publishing-directory "~/sync/Dropbox/public/blog/html"
		 :recursive t
		 :publishing-function org-publish-attachment
		 )
		("blog" :components ("notes" "static" "meta"))))



(provide 'init-org)
