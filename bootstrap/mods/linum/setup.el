(setq linum-packages '(linum-relative))

(defun linum/init ()
  (defvar linum-disable-mode-list
    '(ag-mode
      compilation-mode
      dired-mode
      doc-view-mode
      epresent-mode
      eshell-mode
      help-mode
      image-mode
      markdown-mode
      org-mode
      pdf-view-mode
      project-explorer-mode
      ranger-mode
      speedbar-mode
      term-mode
      undo-tree-visualizer-mode
      Info-mode
      package-menu-mode)
    "The modes in which linum is disabled.")

  (defadvice linum-on (around m|linum/maybe-disable activate)
    (when (not (and (boundp 'linum-disable-mode-list)
                    (memq major-mode linum-disable-mode-list)))
      ad-do-it))
  (m|add-startup-hook #'global-linum-mode)

  (use-package linum-relative
    :defer t
    :diminish linum-relative-mode
    :init
    (m|add-startup-hook #'linum-relative-mode)
    :config
    (setq linum-relative-current-symbol "")))
