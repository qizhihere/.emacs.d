(my/install '(gitignore-mode git-timemachine git-gutter))

(unless (version< emacs-version "24.4")
  (when (my/try-install 'magit)
    ;; disable magit startup messages
    (setq magit-last-seen-setup-instructions "1.4.0"
          magit-push-always-verify nil
          magit-status-buffer-switch-function 'switch-to-buffer)))

;; git-gutter
;; use git-gutter.el with linum-mode
(after-init (git-gutter:linum-setup))

(after-load 'git-gutter
  (diminish 'git-gutter-mode))

;; enable git-gutter-mode for some modes
(add-hook 'prog-mode-hook 'git-gutter-mode)
(add-hook 'fish-mode-hook 'git-gutter-mode)
(add-hook 'vimrc-mode-hook 'git-gutter-mode)

(custom-set-variables
 '(git-gutter:update-interval 1)
 '(git-gutter:modified-sign "~")
 '(git-gutter:added-sign "+")
 '(git-gutter:deleted-sign "-"))



(provide 'init-git)
