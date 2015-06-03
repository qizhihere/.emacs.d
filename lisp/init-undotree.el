(lqz/require '(undo-tree undohist))

(defadvice undo-tree-visualize (around undo-tree-split-side-by-side activate)
  "Split undo-tree side-by-side"
  (let ((split-height-threshold nil)
	(split-width-threshold 10))
	  ad-do-it))

(customize-set-variable 'undohist-directory (lqz/init-dir "tmp/undohist"))
(undohist-initialize)

;; set undotree history file directories
(setq undo-tree-auto-save-history t
      undo-tree-history-directory-alist `(("." . ,(lqz/init-dir "tmp/undodir/"))))

;; integrate undotree history with session
(add-to-list 'desktop-locals-to-save 'buffer-undo-list)



(provide 'init-undotree)
