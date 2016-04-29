(setq evil-ext-packages
      '(evil-anzu
        evil-leader
        evil-args
        evil-matchit
        evil-exchange
        evil-snipe
        evil-surround))

(defun evil-ext/post-init-evil ()
  (global-evil-matchit-mode 1)
  (evil-exchange-install)
  (evil-snipe-mode 1)
  (global-evil-surround-mode 1))

(defun evil-ext/post-init-evil-search ()
  (use-package evil-anzu))

(defun evil-ext/init-evil-args ()
  (use-package evil-args
    :bind (:map evil-inner-text-objects-map
           ("a" . evil-inner-arg)
           :map evil-outer-text-objects-map
           ("a" . evil-outer-arg)
           :map evil-normal-state-map
           ("L" . evil-forward-arg)
           ("H" . evil-backward-arg)
           ("K" . evil-jump-out-args)
           :map evil-motion-state-map
           ("L" . evil-forward-arg)
           ("H" . evil-backward-arg))))

(defun evil-ext/init-evil-exchange ()
  (use-package evil-exchange
    :defer t
    :config
    (setq evil-exchange-key (kbd "zx"))))

(defun evil-ext/init-evil-snipe ()
  (use-package evil-snipe
    :defer t
    :diminish (evil-snipe-mode
               evil-snipe-override-mode
               evil-snipe-local-mode)
    :config
    (setq evil-snipe-repeat-keys t
          evil-snipe-scope 'visible
          evil-snipe-repeat-scope 'whole-visible
          evil-snipe-enable-highlight t
          evil-snipe-enable-incremental-highlight t)))
