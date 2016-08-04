(setq evil-ext-packages
      '(evil-anzu
        evil-leader
        evil-args
        evil-matchit
        evil-exchange
        evil-quickscope
        evil-snipe
        evil-surround))

(defun vim/init-evil-ext ()
  (unless (fboundp 'evil-ext/init)
    (defun evil-ext/init ())
    (loaded evil (m|load-mod 'evil-ext))))

(defun evil-ext/post-init-evil-search ()
  (use-package evil-anzu))

(defun evil-ext/init-evil-matchit ()
  (loaded evil
    (add-hook 'evil-local-mode-hook #'evil-snipe-local-mode))
  (use-package evil-matchit
    :defer t
    :init
    (loaded evil (global-evil-matchit-mode 1))))

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
  (loaded evil
    (defun m|evil-exchange-install ()
      (evil-exchange-install)
      (remove-hook 'evil-local-mode-hook #'m|evil-exchange-install))
    (add-hook 'evil-local-mode-hook #'m|evil-exchange-install))
  (use-package evil-exchange
    :defer t
    :config
    (setq evil-exchange-key (kbd "zx"))))

(defun evil-ext/init-evil-quickscope ()
  (use-package evil-quickscope
    :defer t
    :init
    (add-hook 'evil-local-mode-hook #'turn-on-evil-quickscope-mode)))

(defun evil-ext/init-evil-snipe ()
  (loaded evil
    (add-hook 'evil-local-mode-hook #'evil-snipe-local-mode))
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

(defun evil-ext/init-evil-surround ()
  (loaded evil
    (add-hook 'evil-local-mode-hook #'evil-surround-mode))
  (use-package evil-surround
    :defer t
    :config
    (add-hook 'emacs-lisp-mode-hook
              (lambda () (push '(?` . ("`" . "'")) evil-surround-pairs-alist)))))
