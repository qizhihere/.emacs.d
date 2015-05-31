(setq org-support-shift-select 'always)
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (R . t)
   (ruby . t)
   (ditaa . t)
   (dot . t)
   (octave . t)
   (sqlite . t)
   (perl . t)
   (C . t)
   ))

;; (setq org-babel-python-command "python2")



(provide 'init-org)
