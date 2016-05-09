(setq sh-script-packages '(fish-mode))

(defun sh-script/init ()
  (use-package sh-script
    :defer t
    :config
    (defun m|sh-setup-whitespace-clean ()
      (setq-local m|whitespace-cleanup-style 'trailing))
    (add-hook 'sh-mode-hook #'m|sh-setup-whitespace-clean)))

(defun sh-script/init-fish ()
  (use-package fish-mode
    :defer t
    :mode "\\.fishrc\\'"))
