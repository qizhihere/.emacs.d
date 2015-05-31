(lqz/require 'hydra)

(defun hydra-go-back (&optional callback)
  (if (functionp callback)
      (funcall callback)
    (keyboard-quit)))

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
Delete: [_o_]  only       [_d_]  delete
Buffer: [_bd_] delete     [_bl_] list
  Move: [_s_]  swap
  Misc: [_u_]  undo       [_r_]  redo
  Quit: [_q_]/[C-g]"
  ("h" windmove-left :exit nil)
  ("j" windmove-down :exit nil)
  ("k" windmove-up :exit nil)
  ("l" windmove-right :exit nil)
  ("H" hydra-move-splitter-left :exit nil)
  ("J" hydra-move-splitter-down :exit nil)
  ("K" hydra-move-splitter-up :exit nil)
  ("L" hydra-move-splitter-right :exit nil)
  ("|" split-window-right :exit nil)
  ("_" split-window-below :exit nil)
  ("v" split-window-right :exit nil)
  ("x" split-window-below :exit nil)
  ;; winner-mode must be enabled
  ("u" winner-undo :exit nil)
  ("r" winner-redo :exit nil) ;;Fixme, not working?
  ("o" delete-other-windows :exit t)
  ("s" ace-swap-window :exit nil)
  ("d" delete-window :exit nil)
  ("bd" kill-this-buffer :exit nil)
  ("bl" helm-mini :exit nil)
  ("q" (lambda nil (interactive) (hydra-go-back #'hydra-buffer-menu/body)))
))


;; org-mode
(global-unset-key (kbd "M-o"))
(define-key org-mode-map (kbd "M-o")
(defhydra hydra-org (:color blue
		     :hint  nil
		     :exit  nil)
  "
   View: [_v_]  toggle
 Insert: [_i_]
  Level: [_+_]  add    [_-_]  reduce
  Table: [_D_]  kill line            [_J_] new line
	 [_H_/_J_/_K_/_L_] move line/column
	 [_h_/_j_/_k_/_l_] cursor move
History: [_u_]  undo   [_C-r_] redo
"
  ;; view
  ("v" org-shifttab :exit nil)
  ("gg" outline-up-heading :exit nil)
  ("n" outline-next-visible-heading :exit nil)
  ("p" outline-previous-visible-heading :exit nil)
  ("N" org-forward-heading-same-level :exit nil)
  ("P" org-backward-heading-same-level :exit nil)

  ;; insert contents submenu
  ("i" hydra-org-insert/body)

  ;; level control
  ("+" org-metaright :exit nil)
  ("=" org-metaright :exit nil)
  ("-" org-metaleft :exit nil)

  ;; table control
  ("h" org-table-previous-field :exit nil)
  ("l" org-table-next-field :exit nil)
  ("j" next-line :exit nil)
  ("k" previous-line :exit nil)
  ("H" org-metaleft :exit nil)
  ("L" org-metaright :exit nil)
  ("K" org-metaup :exit nil)
  ("J" org-metadown :exit nil)
  ("C-j" org-table-next-row :exit nil)

  ;; others
  ("D" kill-whole-line :exit nil)
  ("u" undo-tree-undo :exit nil)
  ("C-r" undo-tree-redo :exit nil)
  )
)

(defhydra hydra-org-insert (:color blue
			   :hint   nil)
  "
 Insert: [_ti_] title  [_to_] TODO   [_ta_] tags
	 [_l_]  link   [_i_] img     [_b_]  blockquote
	 [_d_]  Drawer [_c_] column
"
  ;; insert contents
  ("to" org-insert-todo-heading)
  ("ta" org-set-tags-commmand)
  ("i" org-insert-heading-respect-content)
  ("l" org-insert-link)
  ("d" org-insert-drawer)
  ("c" org-insert-columns-dblock)
  ("m" hydra-org/body)
)



(provide 'init-hydra)
