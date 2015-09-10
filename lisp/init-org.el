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
     (php . t))))

(after-load 'org-indent (diminish 'org-indent-mode))
(after-load 'org-table (diminish 'orgtbl-mode))



(provide 'init-org)
