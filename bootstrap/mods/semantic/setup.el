(defun semantic/init ()
  (use-package semantic
    :defer t
    :init
    (add-hook 'prog-mode-hook #'semantic-mode)))
