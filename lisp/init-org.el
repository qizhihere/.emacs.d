(my/install '(org
              org-plus-contrib
              htmlize
              pangu-spacing))

(setq org-support-shift-select   nil
      org-catch-invisible-edits 'org
      error-footnote-define-inline t
      org-src-fontify-natively   t
      org-startup-align-all-tables t
      org-babel-python-command "python2"
      org-babel-sh-command     "bash"
      org-footnote-auto-label   'random
      org-footnote-auto-adjust  nil
      org-todo-keywords		'((sequence "TODO(t)" "|" "DOING" "DELAY" "DONE(d)" "CANCEL(c)"))
      org-todo-keyword-faces    '(("DELAY" . "orange") ("CANCEL" . "gray")))

(my/install 'graphviz-dot-mode)
(add-to-list 'org-src-lang-modes '("dot" . graphviz-dot))

(dolist (hook '(message-mode-hook text-mode-hook mail-mode-hook))
  (add-hook hook 'turn-on-orgtbl))

(add-hook 'org-mode-hook
          (lambda ()
            (my/custom-org-html-funcs)
            (pangu-spacing-mode 1)
            (setq truncate-lines nil
                  fill-column 86)
            (set (make-local-variable 'pangu-spacing-real-insert-separtor) t)
            (linum-mode -1)))

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
     (php . t))))



(provide 'init-org)
