;;----------------------------------------------------------------------------
;; mode line
;;----------------------------------------------------------------------------
;; smart mode line
;; (my/require 'smart-mode-line)
;; (setq sml/vc-mode-show-backend t)
;; (setq sml/no-confirm-load-theme t
;;	  sml/theme 'respectful
;;	  sml/mode-width 'full
;;	  sml/name-width (cons 1 20))
;; (sml/setup)

;; hide some minor modes from mode line
(setq my/rm-blacklist-regexps
	  '("Guide" "Git" "Outl" "snipe" "Anzu" "company"
		"Undo-Tree" "hs" "ivy" "yas" "hl-" "Helm"
		"Rbow" "drag" "ElDoc" "Fly$"))
(setq rm-blacklist (mapconcat 'identity my/rm-blacklist-regexps "\\|"))

;; show current time in mode line
(display-time-mode t)

;; show column number and file size on mode line
(column-number-mode t)
(size-indication-mode t)


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

;; disable menubar
(menu-bar-mode -1)



(provide 'init-style)
