(setq ruby-packages '(robe
                      hydra
                      projectile-rails))

(defun ruby/init ()
  (use-package ruby-mode
    :defer t
    :config
    (setq ruby-insert-encoding-magic-comment nil)))

(defun ruby/init-robe ()
  (use-package robe
    :defer t
    :init
    (add-hook 'ruby-mode-hook #'robe-mode)
    :diminish robe-mode)

  (loaded company
    (add-hook 'ruby-mode-hook
              (lambda () (company/add-local-backend 'company-robe)))))

(defun ruby/init-projectile-rails ()
  (use-package projectile-rails
    :defer t
    :init
    (add-hook 'projectile-mode-hook
              (lambda () (require 'hydra nil t)
                (projectile-rails-on)))
    :bind (:map projectile-rails-mode-map
           ("M-o" . hydra-projectile-rails/body))))
