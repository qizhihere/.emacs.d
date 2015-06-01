(lqz/require 'hydra)

;; text zoom
(defhydra hydra-zoom (global-map "<f2>")
  "zoom"
  ("g" text-scale-increase "in")
  ("l" text-scale-decrease "out"))


;; buffer managment
(define-key Buffer-menu-mode-map "."
(defhydra hydra-buffer-menu (:color pink
			     :hint nil)
  "
^Mark^             ^Unmark^           ^Actions^          ^Search
^^^^^^^^-----------------------------------------------------------------
_m_: mark          _u_: unmark        _x_: execute       _R_: re-isearch
_s_: save          _U_: unmark up     _b_: bury          _I_: isearch
_d_: delete        ^ ^                _g_: refresh       _O_: multi-occur
_D_: delete up     ^ ^                _T_: files only: % -28`Buffer-menu-files-only
_~_: modified
"
  ("m" Buffer-menu-mark)
  ("u" Buffer-menu-unmark)
  ("U" Buffer-menu-backup-unmark)
  ("d" Buffer-menu-delete)
  ("D" Buffer-menu-delete-backwards)
  ("s" Buffer-menu-save)
  ("~" Buffer-menu-not-modified)
  ("x" Buffer-menu-execute)
  ("b" Buffer-menu-bury)
  ("g" revert-buffer)
  ("T" Buffer-menu-toggle-files-only)
  ("O" Buffer-menu-multi-occur :color blue)
  ("I" Buffer-menu-isearch-buffers :color blue)
  ("R" Buffer-menu-isearch-buffers-regexp :color blue)
  ("c" nil "cancel")
  ("v" Buffer-menu-select "select" :color blue)
  ("o" Buffer-menu-other-window "other-window" :color blue)
  ("q" quit-window "quit" :color blue)))


;; window managment
(global-set-key (kbd "C-x w")
(defhydra hydra-window (:color blue
			:exit  nil
			:hint  nil)
  "
 Split: [_|_]  vs         [_]  sp
  Size: [_}_]  wider      [_{_]  narrower       [_+_]  taller       [_=_]  balance
	[_-_]  shrink     [_]  smart shrink
Delete: [_d_]  delete     [_o_]  only
Buffer: [_bd_] delete     [_bl_] list
  Move: [_s_]  swap       [_h_/_j_/_k_/_l_]  move cursor between windows
  Misc: [_u_]  undo       [_r_]  redo
  Quit: [_q_]/[C-g]"

  ("|" split-window-right :exit nil)
  ("_" split-window-below :exit nil)
  ("v" split-window-right :exit nil)
  ("x" split-window-below :exit nil)

  ("}" enlarge-window-horizontally :exit nil)
  ("{" shrink-window-horizontally :exit nil)
  ("+" enlarge-window :exit nil)
  ("=" balance-windows :exit nil)
  ("-" shrink-window :exit nil)
  ("_" shrink-window-if-larger-than-buffer :exit nil)

  ("h" windmove-left :exit nil)
  ("j" windmove-down :exit nil)
  ("k" windmove-up :exit nil)
  ("l" windmove-right :exit nil)

  ("H" hydra-move-splitter-left :exit nil)
  ("J" hydra-move-splitter-down :exit nil)
  ("K" hydra-move-splitter-up :exit nil)
  ("L" hydra-move-splitter-right :exit nil)

  ;; winner-mode must be enabled
  ("u" winner-undo :exit nil)
  ("r" winner-redo :exit nil) ;;Fixme, not working?
  ("o" delete-other-windows :exit t)

  ("s" ace-swap-window :exit nil)
  ("d" delete-window :exit nil)

  ("bd" kill-this-buffer :exit nil)
  ("bl" helm-mini :exit nil)

  ("q" hydra-buffer-menu/body)
))


;; org-mode
(global-unset-key (kbd "M-o"))
(define-key org-mode-map (kbd "M-o")
(defhydra hydra-org (:color blue
		     :hint  nil
		     :exit  nil)
  "
Submenu: [_i_]  _i_nsert         [_t_]   _t_able control

   View: [_v_]  _v_iew toggle    [_gg_]  top heading
	 [_n_]  next heading   [_N_]   next heading in the same level
	 [_p_]  prev heading   [_P_]   next heading in the same level

  Level: [_+_]  add            [_=_]   reduce
History: [_u_]  undo           [_C-r_] redo

[_m_] return to main org menu
"
  ;; view
  ("v" org-shifttab :exit nil)
  ("gg" outline-up-heading :exit nil)
  ("n" outline-next-visible-heading :exit nil)
  ("p" outline-previous-visible-heading :exit nil)
  ("N" org-forward-heading-same-level :exit nil)
  ("P" org-backward-heading-same-level :exit nil)

  ;; submenus
  ("i" hydra-org-insert/body)
  ("t" hydra-org-table/body)

  ;; level control
  ("+" org-metaright :exit nil)
  ("=" org-metaleft :exit nil)

  ;; others
  ("u" undo-tree-undo :exit nil)
  ("C-r" undo-tree-redo :exit nil)

  ;; return to main org menu
  ("m" hydra-org/body)
  )
)


(defhydra hydra-org-table (:color blue
			   :hint   nil)
"
Line/Column: [_-_]  new line       [_|_]   new column      [_] hline
	     [_K_]  Kill line      [\\]  kill column

       Calc: [_s_]  sum            [_cd_]  copy down
     Region: [_co_] copy           [_cu_]  cut             [_p_]  paste          [_w_]  wrap

       Misc: [_I_]  _I_mport file  [_E_]  _E_xport as      [_C_]  _C_onvert region
	     [_e_]  _e_dit field

[_h_/_j_/_k_/_l_] move cursor
[_H_/_J_/_K_/_L_] move line/column
[_m_] return to main org menu
"
  ;; Line/Column
  ("-" org-table-insert-row :exit nil)
  ("_" org-table-insert-hline :exit nil)
  ("|" org-table-insert-column :exit nil)
  ("K" kill-whole-line :exit nil)
  ("\\" org-table-delete-column :exit nil)

  ;; Calc
  ("s" org-table-sum :exit nil)
  ("cd" org-table-copy-down :exit nil)

  ;; Region
  ("co" org-table-copy-region :exit nil)
  ("cu" org-table-cut-region :exit nil)
  ("p" org-table-paste-rectangle :exit nil)
  ("w" org-table-wrap-region :exit nil)

  ;; Misc
  ("I" org-table-import :exit nil)
  ("E" org-table-export :exit nil)
  ("C" org-table-create-or-convert-from-region :exit nil)
  ("e" org-table-edit-field :exit nil)

  ;; move cursor/line/column
  ("h" org-table-previous-field :exit nil)
  ("l" org-table-next-field :exit nil)
  ("j" next-line :exit nil)
  ("k" previous-line :exit nil)
  ("H" org-table-move-column-left :exit nil)
  ("L" org-table-move-column-right :exit nil)
  ("K" org-table-move-row-up :exit nil)
  ("J" org-table-move-row-down :exit nil)

  ;; return to main org menu
  ("m" hydra-org/body)
)


;; (defhydra hydra-org-insert (:color blue
;;			   :hint   nil)
;;   "
;;  Insert: [_ti_] title  [_to_] _to_do   [_ta_] tags
;;	 [_l_]  link   [_i_] img     [_b_]  blockquote
;;	 [_d_]  Drawer [_c_] column
;; "
;;   ;; insert contents
;;   ("to" org-insert-todo-heading)
;;   ("ta" org-set-tags-commmand)
;;   ("i" org-insert-heading-respect-content)
;;   ("l" org-insert-link)
;;   ("d" org-insert-drawer)
;;   ("c" org-insert-columns-dblock)
;;   ("m" hydra-org/body)
;; )


;; (defhydra hydra-org-template (:color blue :hint nil)
;;   "
;; _C_ENTER  _Q_UOTE     _E_XAMPLE       _S_TARTUP
;; _ti_tle   _to_do      _ta_gs          _ti_mestamp
;; _L_ink    _I_MG	 _b_lockquote
;; _l_isp    _e_macs-lisp
;; _l_atex   _p_o=ython2     _i_ndex:
;; _a_scii   _v_erse     _P_erl tangled  _I_NCLUDE:
;; _s_rc     ^ ^         plant_u_ml      _H_TML:
;; _h_tml    ^ ^         ^ ^             _A_SCII:
;; "
;;   ("s" (hot-expand "<s"))
;;   ("E" (hot-expand "<e"))
;;   ("q" (hot-expand "<q"))
;;   ("v" (hot-expand "<v"))
;;   ("c" (hot-expand "<c"))
;;   ("l" (hot-expand "<l"))
;;   ("h" (hot-expand "<h"))
;;   ("a" (hot-expand "<a"))
;;   ("L" (hot-expand "<L"))
;;   ("i" (hot-expand "<i"))
;;   ("ST" (progn
;;	  (insert "#+STARTUP: overview")
;;	  (forward-line)))
;;   ("e" (progn
;;	 (hot-expand "<s")
;;	 (insert "emacs-lisp")
;;	 (forward-line)))
;;   ("p" (progn
;;	 (hot-expand "<s")
;;	 (insert "python2")
;;	 (forward-line)))
;;   ("u" (progn
;;	 (hot-expand "<s")
;;	 (insert "plantuml :file CHANGE.png")
;;	 (forward-line)))
;;   ("P" (progn
;;	 (insert "#+HEADERS: :results output :exports both :shebang \"#!/usr/bin/env perl\"\n")
;;	 (hot-expand "<s")
;;	 (insert "perl")
;;	 (forward-line)))
;;   ("I" (hot-expand "<I"))
;;   ("H" (hot-expand "<H"))
;;   ("A" (hot-expand "<A"))
;;   ("<" self-insert-command "ins")
;;   ("o" nil "quit"))

;; (defun hot-expand (str)
;;   "Expand org template."
;;   (insert str)
;;   (org-try-structure-completion))

;; ;; I bind it for myself like this:

;; (define-key org-mode-map "<"
;;   (lambda () (interactive)
;;      (if (looking-back "^")
;;	 (hydra-org-template/body)
;;        (self-insert-command 1))))


(defhydra hydra-org-template (:color blue :hint nil)
  "
_c_enter  _q_uote     _e_macs-lisp    _L_aTeX:
_l_atex   _E_xample   _p_erl          _i_ndex:
_a_scii   _v_erse     _P_erl tangled  _I_NCLUDE:
_s_rc     ^ ^         plant_u_ml      _H_TML:
_h_tml    _o_rg       ^ ^             _A_SCII:
"
  ("s" (hot-expand "<s"))
  ("E" (hot-expand "<e"))
  ("q" (hot-expand "<q"))
  ("v" (hot-expand "<v"))
  ("c" (hot-expand "<c"))
  ("l" (hot-expand "<l"))
  ("h" (hot-expand "<h"))
  ("a" (hot-expand "<a"))
  ("L" (hot-expand "<L"))
  ("i" (hot-expand "<i"))
  ("e" (progn
	 (hot-expand "<s")
	 (insert "emacs-lisp")
	 (forward-line)))
  ("p" (progn
	 (hot-expand "<s")
	 (insert "perl")
	 (forward-line)))
  ("u" (progn
	 (hot-expand "<s")
	 (insert "plantuml :file CHANGE.png")
	 (forward-line)))
  ("P" (progn
	 (insert "#+HEADERS: :results output :exports both :shebang \"#!/usr/bin/env perl\"\n")
	 (hot-expand "<s")
	 (insert "perl")
	 (forward-line)))
  ("I" (hot-expand "<I"))
  ("H" (hot-expand "<H"))
  ("A" (hot-expand "<A"))
  ("<" self-insert-command "ins")
  ("o" (progn
	 (hot-expand "<s")
	 (insert "org")
	 (forward-line))))

(defun hot-expand (str)
  "Expand org template."
  (insert str)
  (org-try-structure-completion))

;; I bind it for myself like this:

(define-key org-mode-map "<"
  (lambda () (interactive)
     (if (looking-back "^")
	 (hydra-org-template/body)
       (self-insert-command 1))))



(provide 'init-hydra)
