(lqz/require '(undo-tree))

(defadvice undo-tree-visualize (around undo-tree-split-side-by-side activate)
  "Split undo-tree side-by-side"
  (let ((split-height-threshold nil)
    (split-width-threshold 10))
      ad-do-it))

;; set undotree history file directories
(setq history-length 1000
      undo-tree-auto-save-history t
      undo-tree-history-directory-alist `(("." . ,(lqz/init-dir "tmp/undodir/")))
      undo-tree-incompatible-major-modes '(term-mode magit-status-mode))

;; integrate undotree history with session
(add-to-list 'desktop-locals-to-save 'buffer-undo-list)



(provide 'init-undotree)
