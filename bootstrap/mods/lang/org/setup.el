(setq org-packages '(htmlize ob-php org-plus-contrib))

(defun org/init ()
  (loaded org-indent (diminish 'org-indent-mode))
  (loaded org-table (diminish 'orgtbl-mode))
  (use-package org
    :commands org-try-structure-completion
    :bind (:map org-mode-map
           ("<M-return>" . org-insert-heading))
    :config
    (setq org-support-shift-select   nil
          org-catch-invisible-edits 'org
          org-src-fontify-natively   t
          org-startup-align-all-tables t
          org-confirm-babel-evaluate nil
          org-footnote-auto-label   'random
          org-footnote-auto-adjust  nil
          org-todo-keywords		'((sequence "TODO(t)" "|" "DOING" "DELAY" "DONE(d)" "CANCEL(c)"))
          org-todo-keyword-faces    '(("DELAY" . "orange") ("CANCEL" . "gray")))

    (defun m|org-basic-setup ()
      (setq truncate-lines nil
            fill-column 86)
      (linum-relative-off)
      (flyspell-mode-off))
    (add-hook 'org-mode-hook #'m|org-basic-setup)

    ;; i prefer to use lowercase templates
    (push '("C" "#+BEGIN_COMMENT ?\n\n#+END_COMMENT" "")
          org-structure-template-alist)
    (custom-set-variables
     '(org-structure-template-alist
       (mapcar (lambda (x) (setcdr x (mapcar #'downcase (cdr x))) x)
               org-structure-template-alist)))

    (setq org-babel-sh-command "bash")
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
       (php . t)))))

(defun org/init-org-babel ()
  (use-package ob-php :defer t)
  (use-package ob
    :defer t
    :config
    (setq org-babel-python-command "python2")))

(defun org/init-snippet-completion ()
  (use-package org-snippets
    :ensure nil
    :load-path (lambda () (__dir__))
    :commands org-insert-snippet)
  (loaded org
    (bind-keys :map org-mode-map
      ("C-c i" . org-insert-snippet))))
