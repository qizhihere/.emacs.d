(my/install '(org
              htmlize
              pangu-spacing))

(setq org-support-shift-select   nil
      org-catch-invisible-edits 'org
      error-footnote-define-inline t
      org-src-fontify-natively   t
      org-startup-align-all-tables t
      org-babel-python-command "python2"
      org-babel-sh-command     "bash"
      org-confirm-babel-evaluate nil
      org-footnote-auto-label   'random
      org-footnote-auto-adjust  nil
      org-todo-keywords		'((sequence "TODO(t)" "|" "DOING" "DELAY" "DONE(d)" "CANCEL(c)"))
      org-todo-keyword-faces    '(("DELAY" . "orange") ("CANCEL" . "gray")))

(after-load 'pangu-spacing (diminish 'pangu-spacing-mode))

(my/install 'graphviz-dot-mode)
(after-load 'org
  (add-to-list 'org-src-lang-modes '("dot" . graphviz-dot)))

(dolist (hook '(message-mode-hook text-mode-hook mail-mode-hook))
  (add-hook hook 'turn-on-orgtbl))

(add-hook 'org-mode-hook
          (lambda ()
            (my/custom-org-html-funcs)
            (pangu-spacing-mode 1)
            (setq truncate-lines nil
                  fill-column 86)
            (set (make-local-variable 'pangu-spacing-real-insert-separtor) t)
            (linum-mode -1)
            (flyspell-mode -1)))

(after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((sh     . t)
     (python . t)
     (R      . t)
     (ruby   . t)
     (ditaa  . t)
     (dot    . t)
     (octave . t)
     (sqlite . t)
     (perl   . t)
     (C      . t)
     (clojure . t)
     (plantuml . t)
     (latex . t)
     (php . t)))

  ;; i prefer to use lowercase templates
  (custom-set-variables
   '(org-structure-template-alist
     (mapcar (lambda (x) (setcdr x (mapcar #'downcase (cdr x))) x)
             org-structure-template-alist))))

(after-load 'org-indent (diminish 'org-indent-mode))
(after-load 'org-table (diminish 'orgtbl-mode))

;; use helm to quickly insert org-mode snippets
(with-installed 'helm
  (defun hot-expand (str)
    "Expand org template."
    (insert str)
    (org-try-structure-completion))

  (defun my/org-insert-src (&optional params)
    "Quickly insert src block in org-mode."
    (insert (format "#+begin_src%s\n\n#+end_src"
                    (if params (concat " " params) "")))
    (previous-line))

  (defun my/org-insert-header ()
    "Quickly insert note meta info in org-mode."
    (insert (concat "#+title: \n"
                    "#+description: \n"
                    "#+keywords: \n"
                    "#+author: littleqz\n"
                    "#+email: qizhihere@gmail.com\n"
                    "#+date: <" (format-time-string "%Y-%m-%d %b %H:%M") ">\n"
                    "#+startup: indent hideblocks content\n"
                    "#+options: ^:{} toc:t\n"
                    "#+setupfile: ~/org/layouts/blog.setup\n"))
    (previous-line 9)
    (evil-append-line 1))

  (defun my/org-insert-block (&optional block)
    "Quickly insert block in org-mode."
    (when block
      (insert (format "#+begin_%s\n\n#+end_%s"
                      block block))
      (previous-line)))

  (defun my/org-insert-image ()
    (let ((file (file-relative-name
                 (read-file-name "Select an image:") default-directory)))
      (insert (concat "[[" file "]]"))))

  (defun my/org-insert-video ()
    "Quickly insert video in org-mode."
    (let ((file
           (concat "http://v.sudotry.com/"
                   (file-name-nondirectory
                    (my/select-file "Select an video: " "~/sync/Dropbox/video/")))))
      (insert (concat
               "#+begin_html \n"
               "<video autoplay controls loop>\n"
               "\t<source src='" file "' type='video/mp4'/>\n"
               "\tYour browser does not support the video tag.\n"
               "</video>\n"
               "#+end_html"))))

  (setq helm-source-org-src
        (append
         (mapcar (lambda (x) (list x (list x #'my/org-insert-src)))
                 '("c"
                   "coffee"
                   "c++"
                   "css"
                   "emacs-lisp"
                   "html"
                   "java"
                   "javascript"
                   "less"
                   "lisp"
                   "lua"
                   "nginx"
                   "org"
                   "php"
                   "python"
                   "sass"
                   "sh"
                   "sql"
                   "sql"
                   "src"))
         '(("dot" (lambda () (my/org-insert-src
                              (format "dot :file ../img/figure-%s.svg :cmdline -Kdot -Tsvg"
                                      (substring (my/random-uuid) 0 8)))))
           ))

        helm-source-org-block
        '(("#+begin_center" (lambda () (hot-expand "<c")))
          ("#+begin_comment" (lambda () (my/org-insert-block "comment")))
          ("#+begin_example" (lambda () (hot-expand "<e")))
          ("#+begin_html" (lambda () (hot-expand "<h")))
          ("#+begin_quote" (lambda () (hot-expand "<q")))
          ("#+begin_verse" (lambda () (hot-expand "<v")))
          ("drawer" org-insert-drawer)
          ("video" my/org-insert-video)
          ("table column" org-insert-columns-dblock))

        helm-source-org-inline
        '(("header" my/org-insert-header)
          "#+title: "
          "#+author: littleqz"
          "#+options: ^:{} toc:2"
          "#+startup: "
          "#+caption: \n#+name:\t"
          "#+name: "
          ("#+include: " (lambda () (hot-expand "<I")))
          ("#+index: " (lambda () (hot-expand "<i")))
          "#+macro: "
          ("[ ] checkbox" (lambda () (org-meta-return)
                            (insert "[ ] ")))
          ("* TODO" (lambda () (call-interactively #'org-insert-todo-heading)))
          ("footnote" org-footnote-action)
          ("inline footnote" (lambda ()
                               ("link/href" org-insert-link)
                               (insert (concat "[fn::]"))
                               (backward-char)))
          ("invisible space" "\u200B")
          ("image" my/org-insert-image)
          ("latex" (lambda () (hot-expand "<L")))
          ("timestamp" (lambda ()
                         (insert (concat "<" (format-time-string "%Y-%m-%d %b %H:%M") ">"))))
          ("timestamp(interactively)" (lambda () (call-interactively 'org-time-stamp)))
          ))


  (defun my/helm-org-snippets ()
    "Quickly insert snippets in org-mode using helm."
    (interactive)
    (let* ((item (helm :sources (list (helm-build-sync-source "Src"
                                        :candidates helm-source-org-src)
                                      (helm-build-sync-source "Blocks"
                                        :candidates helm-source-org-block)
                                      (helm-build-sync-source "Inline"
                                        :candidates helm-source-org-inline))
                       :buffer "*helm org snippets*")))
      (when (listp item)
        (setq item (car item)))
      (cond
       ((symbolp item)
        (and (symbol-function item)
             (funcall (symbol-function item))))
       ((functionp item) (funcall item))
       ((listp item)
        (let* ((func (if (symbolp (cadr item))
                         (symbol-function (cadr item))))
               (str (if (stringp (car item)) (car item) "")))
          (unless func (setq func #'insert))
          (funcall func str)))
       ((stringp item) (insert item)))))

  (after-load 'org
    (define-key org-mode-map (kbd "C-c i") 'my/helm-org-snippets))

  )



(provide 'init-org)
