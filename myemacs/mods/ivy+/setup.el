(setq ivy+-packages '(ivy
                      counsel))

(defun ivy+/init ()
  (use-package ivy
    :diminish ivy-mode
    :leader ("fr" ivy-recentf)
    :bind (("C-c C-f" . ivy-recentf)
           :map ivy-minibuffer-map
           ("C-l" . ivy-backward-kill-word)
           ("C-j" . ivy-immediate-done))
    :init
    (m|add-idle-hook #'ivy-mode)
    :config
    (setq ivy-use-virtual-buffers t
          ivy-initial-inputs-alist nil
          ivy-format-function 'ivy-format-function-arrow)

    (setq ivy-re-builders-alist
          '((execute-extended-command . ivy--regex-fuzzy)
            (counsel-M-x . ivy--regex-fuzzy)
            (t . ivy--regex-plus)))))

(defun ivy+/post-init-magit ()
  (setq magit-completing-read-function 'ivy-completing-read))

(defun ivy+/post-init-projectile ()
  (setq projectile-completion-system 'ivy))

(defun ivy+/init-counsel ()
  (use-package counsel
    :bind (("M-x" . counsel-M-x)
           ("M-y" . counsel-yank-pop)
           ("C-c u" . counsel-unicode-char)
           ("C-c j i" . counsel-imenu))
    :leader ("ji" counsel-imenu)))
