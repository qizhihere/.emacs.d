(setq ivy+-packages '(flx
                      smex
                      ivy
                      counsel))

(defun ivy+/init ()
  ;; use flx and smex to make ivy more accurate and intelligent
  (use-package flx :defer t)
  (use-package smex
    :defer t
    :config
    (setq smex-save-file (m|cache-dir "smex-items")))

  (use-package ivy
    :diminish ivy-mode
    :init
    (m|add-startup-hook #'ivy-mode)
    :leader ("fr" ivy-recentf)
    :bind (("C-c C-f" . ivy-recentf)
           :map ivy-minibuffer-map
           ("C-l" . ivy-backward-kill-word)
           ("C-j" . ivy-immediate-done))
    :config
    (setq ivy-use-virtual-buffers t
          ivy-format-function 'ivy-format-function-arrow)

    (setq ivy-re-builders-alist
          '((t . ivy--regex-fuzzy)))))

(defun ivy+/post-init-magit ()
  (setq magit-completing-read-function 'ivy-completing-read))

(defun ivy+/post-init-projectile ()
  (setq projectile-completion-system 'ivy))

(defun ivy+/init-counsel ()
  (use-package counsel
    :bind (("M-x" . counsel-M-x)
           ("M-y" . counsel-yank-pop)
           ("C-c u" . counsel-unicode-char)
           ("C-c j i" . counsel-imenu)
           ("C-h f" . counsel-describe-function)
           ("C-h v" . counsel-describe-variable)
           ("C-x C-f" . counsel-find-file))
    :leader ("ji" counsel-imenu)))
