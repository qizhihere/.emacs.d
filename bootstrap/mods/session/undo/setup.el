(setq undo-packages '(undo-tree))

(defun undo/init ()
  (use-package undo-tree
    :init
    (m|add-startup-hook #'global-undo-tree-mode)
    :leader ("un" undo-tree-visualize)
    :diminish undo-tree-mode
    :config
    (setq history-length 100000
          undo-outer-limit 50000000
          undo-tree-auto-save-history t
          undo-tree-history-directory-alist `(("." . ,(m|cache-dir "undo")))
          undo-tree-incompatible-major-modes '(term-mode magit-status-mode))

    (defun m|undo-tree--split-window-right-advice (orig-func &rest args)
      (let ((split-height-threshold nil)
            (split-width-threshold 10))
        (apply orig-func args)))
    (advice-add 'undo-tree-visualize :around #'m|undo-tree--split-window-right-advice)))
