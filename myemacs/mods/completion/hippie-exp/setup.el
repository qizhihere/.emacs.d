(defun hippie-exp/init ()
  (use-package hippie-exp
    :bind (("M-/" . hippie-expand))
    :config
    (m|load-relative "hippie-exp-utils" #$)
    (setq hippie-expand-try-functions-list
          '(try-expand-dabbrev
            try-expand-dabbrev-all-buffers
            try-expand-dabbrev-from-kill
            try-complete-file-name-partially
            try-complete-file-name
            try-expand-all-abbrevs
            try-expand-list
            try-expand-line
            try-complete-lisp-symbol-partially
            try-complete-lisp-symbol
            try-expand-by-dict))))
