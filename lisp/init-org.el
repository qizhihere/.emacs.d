(setq org-support-shift-select   nil
      org-catch-invisible-edits 'error
      org-footnote-define-inline t
      org-src-fontify-natively   t
      org-startup-align-all-tables t
      org-footnote-auto-label   'random
      org-footnote-auto-adjust  nil
      org-export-with-sub-superscripts '{}
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

(if (display-graphic-p)
    (set-face-attribute 'org-level-1 nil :height 1.1 :bold t)
    (set-face-attribute 'org-level-2 nil :height 1.0 :bold t)
    (set-face-attribute 'org-level-3 nil :height 0.8 :bold nil))



(provide 'init-org)
