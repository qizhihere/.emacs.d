(setq sh-script-packages '(fish-mode))

(defun sh-script/init ()
  (use-package sh-script
    :defer t
    :mode (("zshrc\\|zshenv\\|zlogin\\|zlogout\\|zpreztorc\\|zprofile" . sh-mode))
    :config
    (defun m|sh-setup-whitespace-clean ()
      (setq-local m|whitespace-cleanup-style 'trailing))
    (add-hook 'sh-mode-hook #'m|sh-setup-whitespace-clean)))

(defun sh-script/init-fish ()
  (use-package fish-mode
    :defer t
    :mode "\\.fishrc\\'"
    :config
    (setq fish-imenu-generic-function
          '(("Alias" "^[ib]?alias *\\([^ \n]*\\)" 1)
            ("Function" "^function *\\([^ \n]*\\)" 1)))
    (add-hook 'fish-mode-hook
              (lambda ()
                (setq imenu-generic-expression fish-imenu-generic-function)))))
