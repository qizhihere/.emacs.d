(setq org-support-shift-select  'always
      org-catch-invisible-edits 'error
      org-footnote-define-inline t
      org-footnote-auto-label   'random
      org-footnote-auto-adjust  nil)
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
(add-hook 'message-mode-hook 'turn-on-orgtbl)
(add-hook 'text-mode-hook 'turn-on-orgtbl)
(add-hook 'mail-mode-hook 'turn-on-orgtbl)

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

(setq org-babel-python-command "python2")



(provide 'init-org)
