(setq git-packages '(magit
                     git-gutter
                     git-messenger
                     git-timemachine))

(defun git/init ()
  (use-package magit
    :commands (magit-blame-mode
               magit-commit-popup
               magit-diff-popup
               magit-log-popup)
    :leader ("gc" magit-commit-popup
             "gC" magit-checkout
             "gd" magit-diff-popup
             "ge" magit-ediff-compare
             "gE" magit-ediff-show-working-tree
             "gf" magit-fetch-popup
             "gF" magit-pull-popup
             "gi" magit-init
             "gll" magit-log-current
             "glr" magit-reflog-current
             "gla" magit-log-all
             "gL" magit-log-buffer-file
             "gs" magit-status
             "gS" magit-stage-file
             "gU" magit-unstage-file)
    :config
    (setq magit-auto-revert-mode nil)

    ;; display magit buffer with fullscreen
    (advice-add 'magit-status :after #'m|fullscreen-post-advice)))

(defun git/init-git-messenger ()
  (use-package git-messenger
    :leader ("gm" git-messenger:popup-message)
    :config
    (define-key git-messenger-map [escape] #'git-messenger:popup-close)))

(defun git/init-git-timemachine ()
  (use-package git-timemachine
    :leader ("gt" git-timemachine)))

(defun git/init-git-gutter ()
  (use-package git-gutter
    :disabled t
    :defer t
    :diminish git-gutter-mode
    :init
    (m|add-startup-hook #'global-git-gutter-mode t)
    :config
    ;; (loaded linum (git-gutter:linum-setup))
    (custom-set-variables
     '(git-gutter:update-interval 1)
     '(git-gutter:modified-sign "~")
     '(git-gutter:added-sign "+")
     '(git-gutter:deleted-sign "-"))))
