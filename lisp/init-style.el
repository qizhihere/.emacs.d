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

;;----------------------------------------------------------------------------
;; mode line format
;;----------------------------------------------------------------------------
(defvar my/window-numbering-mode-line
  (when (my/try-install 'window-numbering)
	'(" "
	  (:propertize
	   (:eval (concat "[" (number-to-string (window-numbering-get-number)) "]"))
	   face window-numbering-face)))
  "Mode line format for window-numbering.")

(defvar my/vc-mode-line
  '(" " (:propertize
		 (:eval (let ((backend (symbol-name (vc-backend (buffer-file-name)))))
				  (substring vc-mode (+ (length backend) 2))))
		 face font-lock-keyword-face))
  "Mode line format for VC Mode.")

(defvar my/projectile-mode-line
  '(:propertize
	(:eval (when (ignore-errors (projectile-project-root))
			 (concat " " (projectile-project-name))))
	face (font-lock-keyword-face bold))
  "Mode line format for Projectile.")

(dolist (var '(my/vc-mode-line
			   my/window-numbering-mode-line
			   my/projectile-mode-line))
  (put var 'risky-local-variable t))

(setq-default mode-line-position '(+12 (line-number-mode
										(-12 "%l" (+3 (column-number-mode ":%c"))))
									   (-4 " %p"))
			  evil-mode-line-format '(after . my/window-numbering-mode-line))

(setq-default mode-line-format
			  '("%e"
				my/window-numbering-mode-line
				evil-mode-line-tag
				" "
				mode-line-mule-info
				mode-line-client
				mode-line-modified
				mode-line-remote
				mode-line-frame-identification
				;; buffer file and file size
				(-60 (+60
					  (+22 (-40
							(:eval (propertized-buffer-identification "%b")))
						   "  " (size-indication-mode (-4 "%I")))
					  "   "
					  mode-line-position
					  ;; projectile and git
					  (+16 (-16 (:eval my/projectile-mode-line))
						   (-6 (vc-mode my/vc-mode-line)))))
				(+15 (-15 (:eval (wg-mode-line-string))))
				(+24 (-24 (:eval mode-line-modes)))
				mode-line-misc-info
				mode-line-end-spaces))



(provide 'init-style)
