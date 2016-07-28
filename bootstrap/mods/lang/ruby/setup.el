(setq ruby-packages '(inf-ruby
                      robe
                      hydra
                      projectile-rails))

(defun ruby/init ()
  (use-package ruby-mode
    :defer t
    :config
    (setq ruby-insert-encoding-magic-comment nil)

    (loaded smartparens (require 'smartparens-ruby))))

(defun ruby/init-robe ()
  (use-package robe
    :defer t
    :init
    (add-hook 'ruby-mode-hook #'robe-mode)
    :diminish robe-mode
    :config
    (loaded company
      (m|be-quiet company-robe)

      (defun m|company-add-robe-backend ()
        (company/add-local-backend 'company-robe))
      (add-hook 'robe-mode-hook #'m|company-add-robe-backend)

      (defun m|robe-dot-try-complete ()
        (interactive)
        (when (looking-back "\\.")
          (silently (company-complete-common)))
        (indent-for-tab-command))
      (bind-key "TAB" #'m|robe-dot-try-complete robe-mode-map))))

(defun ruby/init-projectile-rails ()
  (use-package projectile-rails
    :defer t
    :init
    (add-hook 'projectile-mode-hook
              (lambda () (require 'hydra nil t)
                (projectile-rails-on)))
    :config
    (bind-keys :map projectile-rails-mode-map
      ("M-o" . hydra-projectile-rails/body))))

(defun ruby/init-repl ()
  (use-package inf-ruby :defer t)
  (loaded ruby-mode
    (define-repl ruby-repl ()
      "Run irb in a buffer."
      (let ((buf (bound-and-true-p inf-ruby-buffer)))
        (or (and buf (get-buffer buf))
            (inf-ruby-console-auto))))

    (bind-keys :map ruby-mode-map
      ("C-c <f12>" . ruby-repl)
      ("C-c C-<f12>" . ruby-repl-maximized))))
