;; set blog page header and footer html raw string
(setq org-html-preamble-format (list (list "en" (cat "~/org/layouts/header.html")))
      org-html-postamble-format (list (list "en" (cat "~/org/layouts/footer.html"))))

(setq my/org-base-directory "~/org/"
      my/org-publish-directory "~/sync/Dropbox/public/blog/html"
      my/org-post-directory (concat my/org-base-directory "posts/"))

(defun my/new-note (file)
  "Create a new note."
  (interactive "sPlease input note filename: ")
  (find-file (concat my/org-post-directory file))
  (my/org-insert-header))

(defun my/open-note ()
  "Open a note."
  (interactive)
  (find-file (read-file-name "Select a note: " my/org-post-directory)))

(defun my/current-timestamp ()
  "Insert current timestamp."
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

(defun my/update-note-index ()
  "Update post lists."
  (interactive)
  (require 'ox-publish)
  ;; regenerate note list
  (cl-flet (((symbol-function 'org-publish-file) (lambda (&rest args) '())))
    (org-publish-projects (list (assoc "notes" org-publish-project-alist))))
  ;; force update index.org
  (shell-command (concat "touch " my/org-base-directory "index.org"))
  (org-publish-project (assoc "notes-index" org-publish-project-alist) t))

(defadvice org-publish-org-sitemap (around my/org-publish-sitemap-advice activate)
  "Disable some modes to speed up sitemap generating."
  (cl-flet (((symbol-function 'evil-mode-enable-in-buffers) (lambda () t)))
    ad-do-it))

;; export settings
(setq org-export-with-sub-superscripts '{}
      org-html-htmlize-output-type 'css
      org-html-footnote-format  "<sup>%s</sup>"
      org-odt-preferred-output-format  "pdf"
      org-publish-project-alist
      `(("notes"
         :author "littleqz"
         :email "qizhihere@gmail.com"
         :base-directory ,my/org-post-directory
         :base-extension "org"
         :exclude ".*draft.org"
         :headline-levels 4
         :html-extension "html"
         :html-link-home "/"
         :html-link-up "../"
         :html-postamble t
         :html-preamble t
         :publishing-directory ,my/org-publish-directory
         :publishing-function org-html-publish-to-html
         :recursive t
         :section-numbers nil
         :auto-sitemap t                  ; Generate sitemap.org automagically
         :sitemap-date-format "%Y.%m.%d"
         :sitemap-file-entry-format "%d » %t"
         :sitemap-filename "post-list.org"  ; by default it is sitemap.org
         :sitemap-sort-files anti-chronologically  ; sort file time reversely
         :sitemap-sort-folders last
         :sitemap-title " "         ; i need only a post list without title.
         )
        ("notes-index"
         :base-directory ,my/org-base-directory
         :base-extension "org"
         :html-extension "html"
         :exclude "node_modules\\|gulpfile.js\\|.git\\|\\.#.*"
         :publishing-directory ,my/org-publish-directory
         :recursive nil
         :publishing-function org-html-publish-to-html
         :html-postamble t
         :html-preamble t
         )
        ("resources"
         :base-directory "~/org"
         :exclude ".git\\|node_modules\\|gulpfile.js"
         :base-extension "ico\\|css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|mp4\\|ogg\\|swf\\|eot\\|svg\\|ttf\\|woff\\|woff2"
         :publishing-directory ,my/org-publish-directory
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("blog" :components ("notes"  "notes-index" "resources"))))



(provide 'init-org-blog)
