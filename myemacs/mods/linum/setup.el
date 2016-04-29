(setq linum-packages '(linum-relative))

(defun linum/init ()
  (defvar linum-disable-mode-list
    '(org-mode
      markdown-mode
      dired-mode
      doc-view-mode
      pdf-view-mode
      help-mode
      undo-tree-visualizer-mode
      Info-mode
      eshell-mode
      compilation-mode
      epresent-mode
      speedbar-mode)
    "The modes in which linum is disabled.")

  (defadvice linum-on (around m|linum/maybe-disable activate)
    (when (not (and (boundp 'linum-disable-mode-list)
                    (memq major-mode linum-disable-mode-list)))
      ad-do-it))

  (use-package linum-relative
    :defer t
    :diminish linum-relative-mode
    :config
    (setq linum-relative-current-symbol ""
          linum-relative-format "%2s "))

  (m|add-idle-hook #'global-linum-mode)
  (m|add-idle-hook #'linum-relative-mode))
