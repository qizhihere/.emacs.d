(defun clipboard/init ()
  (use-package x-clipboard
    :ensure nil
    :load-path (lambda () (__dir__))
    :bind (("C-c cy" . xcopy)
           ("C-c cp" . xpaste)
           ("C-c cx" . xcut))))
