(setq markdown-packages '(markdown-mode))

(defun markdown/init ()
  (use-package markdown-mode
    :bind (:map markdown-mode-map
           ("M-RET" . markdown-insert-header-dwim))))
