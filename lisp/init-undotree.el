(my/install 'undo-tree)

(defadvice undo-tree-visualize (around undo-tree-split-side-by-side activate)
  "Split undo-tree side-by-side"
  (let ((split-height-threshold nil)
		(split-width-threshold 10))
	ad-do-it))

(setq history-length 100000
	  undo-outer-limit 50000000
	  undo-tree-history-directory-alist `(("." . ,(my/init-dir "tmp/undodir/")))
	  undo-tree-incompatible-major-modes '(term-mode magit-status-mode)
	  undohist-directory (my/init-dir "tmp/undodir"))


;; (after-init
;;   (global-undo-tree-mode)
;;   (diminish 'undo-tree-mode))

;; undo history persistent
(my/require 'undohist)
(undohist-initialize)



(provide 'init-undotree)
