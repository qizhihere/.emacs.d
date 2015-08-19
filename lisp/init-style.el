;; show current time in mode line
(display-time-mode t)

;; show column number and file size on mode line
(column-number-mode t)
(size-indication-mode t)

;; hide bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;----------------------------------------------------------------------------
;; line/column number
;;----------------------------------------------------------------------------
;; relative line number
(my/require 'linum-relative)

;; adjust space between line number and content
(setq linum-relative-current-symbol "->"
	  linum-relative-format "%2s ")

;; disable linum in certin modes(especially for doc-view-mode,
;; enabling linum may hangs emacs out)
(setq linum-disable-mode-list
	  '(org-mode dired-mode doc-view-mode help-mode undo-tree-visualizer-mode Info-mode))
(defadvice linum-mode (around my/setup-linum activate)
  (when (not (and (boundp 'linum-disable-mode-list)
				  (member major-mode linum-disable-mode-list)))
	ad-do-it))
(global-linum-mode)



(provide 'init-style)
