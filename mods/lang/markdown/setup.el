(setq markdown-packages '(markdown-mode))

(defun markdown/init ()
  (use-package markdown-mode
    :bind (:map markdown-mode-map
           ("M-RET" . markdown-M-RET-dwim)
           ("M-<return>" . markdown-M-RET-dwim))))

(defun markdown/init-snippet-completion ()
  (use-package markdown-snippets
    :ensure nil
    :load-path (lambda () (__dir__))
    :commands markdown-insert-snippet)
  (loaded markdown-mode
    (bind-keys :map markdown-mode-map
      ("C-c i" . markdown-insert-snippet))))
