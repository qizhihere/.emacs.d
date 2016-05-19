(setq vim-packages '(evil
                     evil-escape
                     evil-leader))

(defun vim/init ()
  (use-package evil
    :commands evil-normal-state
    :bind (:map evil-normal-state-map
           ([remap evil-next-line] . evil-next-visual-line)
           ([remap evil-previous-line] . evil-previous-visual-line)
           ([remap evil-yank-line] . yank-line-no-eol))
    :init
    (m|add-startup-hook #'evil-mode)

    :config
    (setq evil-move-cursor-back nil
          ;; undo should behave like vim instead of emacs
          evil-want-fine-undo nil
          evil-in-single-undo t
          evil-want-C-d-scroll nil
          evil-want-C-i-jump t
          evil-want-C-w-delete t)

    (setq-default evil-symbol-word-search t)

    ;; use evil internal search for `gn/gN` support
    (setq evil-search-module 'evil-search
          evil-ex-search-persistent-highlight nil)

    ;; setup states
    (setq evil-default-state 'normal)
    (merge-to evil-emacs-state-modes
      '(dired-mode
        edebug-mode
        pdf-view-mode
        view-mode
        pdf-outline-buffer-mode
        git-timemachine-mode
        messages-buffer-mode))
    (merge-to evil-normal-state-modes
      '(prog-mode text-mode org-mode))
    (merge-to evil-buffer-regexps
      '(("^\\*scratch\\*" . normal)
        ("^\\*[^*]+\\*\\'" . emacs)
        ("^timemachine:" . emacs)))

    (m|load-conf "setup-evil" vim)
    (m|load-conf "more-text-objects" vim)))

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
