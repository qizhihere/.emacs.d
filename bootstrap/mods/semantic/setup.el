(defun semantic/init ()
  (use-package semantic
    :defer t
    :init
    (add-hook 'prog-mode-hook #'semantic-mode)
    :config
    (setq semanticdb-default-save-directory (m|cache-dir "semanticdb"))))
