(defun semantic/init ()
  (use-package semantic
    :defer t
    :init
    (m|add-startup-hook 'semantic-mode)))
