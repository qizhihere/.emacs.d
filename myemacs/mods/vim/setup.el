(setq vim-packages '(evil
                     evil-escape
                     evil-leader))

(defun vim/init ()
  (use-package evil
    :commands evil-normal-state
    :bind (:map evil-normal-state-map
           ([remap evil-next-line] . evil-next-visual-line)
           ([remap evil-previous-line] . evil-previous-visual-line))
    :init
    (m|add-idle-hook #'evil-mode)

    :config
    (setq evil-default-state 'emacs
          evil-move-cursor-back nil
          ;; undo should behave like vim instead of emacs
          evil-want-fine-undo nil
          evil-in-single-undo t
          evil-want-C-d-scroll nil
          evil-want-C-i-jump t
          evil-want-C-w-delete t)

    ;; use evil internal search for `gn/gN` support
    (setq evil-search-module 'evil-search
          evil-ex-search-persistent-highlight nil)

    ;; specify when to use which state
    (setq m|evil-emacs-state-modes
          '(edebug-mode
            pdf-view-mode
            view-mode
            pdf-outline-buffer-mode)
          m|evil-normal-state-modes
          '(prog-mode text-mode org-mode))

    (m|load-relative "setup-evil" #$)))

(defun vim/init-evil-ext ()
  (unless (fboundp 'evil-ext/init)
    (defun evil-ext/init ())
    (loaded evil (m|load-mod 'evil-ext))))

(defun vim/init-evil-leader ()
  (use-package evil-leader
    :defer t
    :config
    (evil-leader/set-leader ";"))

  (defun m|evil--prepare-evil-leader (&optional arg)
    (unless (bound-and-true-p evil-mode)
      (global-evil-leader-mode 1)
      (advice-remove 'evil-mode #'m|evil--prepare-evil-leader)))
  (advice-add 'evil-mode :before #'m|evil--prepare-evil-leader))

(defun vim/post-init-undo-tree ()
  (diminish 'undo-tree-mode))

(defun vim/init-evil-escape ()
  (use-package evil-escape
    :defer t
    :diminish evil-escape-mode
    :config
    (setq-default evil-escape-key-sequence "jk"
                  evil-escape-delay 0.15))
  (add-hook 'evil-mode-hook #'evil-escape-mode))

(defun vim/post-init-company ()
  (add-hook 'evil-insert-state-exit-hook 'company-abort))
