(lqz/require '(hydra org))

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
  Quit: [_q_]/[C-g]
"
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
         [\^]  go up          [Tab] toggle subtree

  Level: [_+_]  add            [_=_]   reduce
History: [_u_]  undo           [_C-r_] redo

Export&  [_eh_] html           [_em_] markdown         [_ea_] ascii         [_eu_] utf8
Import : []

[_m_] return to main org menu
"
  ;; view
  ("v" org-shifttab :exit nil)
  ("gg" outline-up-heading :exit nil)
  ("n" outline-next-visible-heading :exit nil)
  ("p" outline-previous-visible-heading :exit nil)
  ("N" org-forward-heading-same-level :exit nil)
  ("P" org-backward-heading-same-level :exit nil)
  ("^" org-up-element :exit nil)
  ;; ("`" org-up-element :exit nil)
  ("TAB" org-cycle :exit nil)

  ;; submenus
  ("i" hydra-org-insert/body)
  ("t" hydra-org-table/body)

  ;; level control
  ("+" org-metaright :exit nil)
  ("=" org-metaleft :exit nil)

  ;; others
  ("u" undo-tree-undo :exit nil)
  ("C-r" undo-tree-redo :exit nil)

  ;; export and import
  ("eh" org-html-export-to-html :exit nil)
  ("em" org-md-export-to-markdown :exit nil)
  ("ea" org-ascii-export-to-ascii :exit nil)
  ("eu" org-html-export-to-html :exit nil)

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


(defhydra hydra-org-insert (:color blue
                                   :hint   nil)
  "
_HE_ADER     _TI_TLE      _AU_THOR   _OP_TIONS
_ST_ARTUP    C_EN_TER     _Q_UOTE    _EX_AMPLE
_S_RC        _TO_DO       _ch_eckbox _t_imestamp
_Me_ta       _NA_ME       _f_ootnote _F_ootnote definition
_l_isp       _em_acs-lisp _C_        C_+_+
_py_thon2    _ph_p        _ng_inx    _sh_ell
_ja_vascript _ht_ml       _cs_s      l_u_a
_IM_G        _L_ink       _d_rawer   _co_lumn
L_a_tex      _O_rg        _V_ERSE    COM_ME_NT
I_NC_LUDE    I_ND_EX      _MA_CRO    _HT_ML

[_m_] return to main org menu
"
  ("HE" (progn
          (insert "#+TITLE: \n#+AUTHOR: littleqz\n#+STARTUP: overview\n#+OPTIONS: ^:{} toc:2")
          (goto-line 1)
          (evil-append-line 1)))
  ("TI" (insert "#+TITLE: "))
  ("AU" (insert "#+AUTHOR: littleqz"))
  ("OP" (insert "#+OPTIONS: ^:{} toc:2"))

  ("ST" (progn
          (insert "#+STARTUP: ")))
  ("EN" (hot-expand "<c"))
  ("Q" (hot-expand "<q"))
  ("EX" (hot-expand "<e"))

  ("S" (hot-expand "<s"))
  ("TO" (org-insert-todo-heading))
  ("ch" (progn
          (org-meta-return)
          (insert "[ ] ")))
  ("t" (insert "TIMESTAMP"))

  ("Me" (insert "#+CAPTION: \n#+NAME:\t"))
  ("NA" (insert "#+NAME: "))
  ("f" (org-footnote-action))
  ("F" (org-footnote-create-definition))

  ("l" (progn
         (hot-expand "<s")
         (insert "lisp")
         (forward-line)))
  ("em" (progn
         (hot-expand "<s")
         (insert "emacs-lisp")
         (forward-line)))
  ("C" (progn
         (hot-expand "<s")
         (insert "C")
         (forward-line)))
  ("+" (progn
          (hot-expand "<s")
          (insert "cpp")
          (forward-line)))

  ("py" (progn
          (hot-expand "<s")
          (insert "python2")
          (forward-line)))
  ("ph" (progn
           (hot-expand "<s")
           (insert "php")
           (forward-line)))
  ("ng" (progn
          (hot-expand "<s")
          (insert "nginx")
          (forward-line)))
  ("sh" (progn
          (hot-expand "<s")
          (insert "sh")
          (forward-line)))

  ("ja" (progn
          (hot-expand "<s")
          (insert "js")
          (forward-line)))
  ("ht" (progn
          (hot-expand "<s")
          (insert "html")
          (forward-line)))
  ("cs" (progn
          (hot-expand "<s")
          (insert "css")
          (forward-line)))
  ("u" (progn
          (hot-expand "<s")
          (insert "lua")
          (forward-line)))

  ("IM" (progn
        (let ((file (file-relative-name
                (read-file-name "Select an image:") default-directory)))
        (insert (concat "[[./" file "]]")))))
  ("L" org-insert-link)
  ("d" org-insert-drawer)
  ("co" org-insert-columns-dblock)

  ("a" (hot-expand "<L"))
  ("O" (progn
          (hot-expand "<s")
          (insert "org")
          (forward-line)
          (org-edit-src-code)))
  ("V" (hot-expand "<v"))
  ("ME" (progn
        (next-line)
        (beginning-of-line)
        (insert "#+BEGIN_COMMENT\n\n#+END_COMMENT"
        (previous-line))))

  ("NC" (hot-expand "<I"))
  ("ND" (hot-expand "<i"))
  ("MA" (insert "#+MACRO: "))
  ("HT" (hot-expand "<h"))

  ("<" self-insert-command "INS")
  ("q" nil)

  ;; return to main org menu
  ("m" hydra-org/body))

(defun hot-expand (str)
  "expand org template."
  (insert str)
  (org-try-structure-completion))

(define-key org-mode-map "<"
  (lambda () (interactive)
    (if (looking-back "^")
        (hydra-org-insert/body)
      (self-insert-command 1))))


;; (DEFHYDRA HYDRA-ORG-TEMPLATE (:COLOR BLUE :HINT NIL)
;;   "
;; _C_ENTER  _Q_UOTE     _E_MACS-LISP    _l_AtEx:
;; _L_ATEX   _e_XAMPLE   _P_ERL          _I_NDEX:
;; _A_SCII   _V_ERSE     _p_ERL TANGLED  _i_nclude:
;; _S_RC     ^ ^         PLANT_U_ML      _h_tml:
;; _H_TML    _O_RG       ^ ^             _a_scii:
;; "
;;   ("S" (HOT-EXPAND "<S"))
;;   ("e" (HOT-EXPAND "<E"))
;;   ("Q" (HOT-EXPAND "<Q"))
;;   ("V" (HOT-EXPAND "<V"))
;;   ("C" (HOT-EXPAND "<C"))
;;   ("L" (HOT-EXPAND "<L"))
;;   ("H" (HOT-EXPAND "<H"))
;;   ("A" (HOT-EXPAND "<A"))
;;   ("l" (HOT-EXPAND "<l"))
;;   ("I" (HOT-EXPAND "<I"))
;;   ("E" (PROGN
;;   (HOT-EXPAND "<S")
;;   (INSERT "EMACS-LISP")
;;   (FORWARD-LINE)))
;;   ("P" (PROGN
;;   (HOT-EXPAND "<S")
;;   (INSERT "PERL")
;;   (FORWARD-LINE)))
;;   ("U" (PROGN
;;   (HOT-EXPAND "<S")
;;   (INSERT "PLANTUML :FILE change.PNG")
;;   (FORWARD-LINE)))
;;   ("p" (PROGN
;;   (INSERT "#+headers: :RESULTS OUTPUT :EXPORTS BOTH :SHEBANG \"#!/USR/BIN/ENV PERL\"\N")
;;   (HOT-EXPAND "<S")
;;   (INSERT "PERL")
;;   (FORWARD-LINE)))
;;   ("i" (HOT-EXPAND "<i"))
;;   ("h" (HOT-EXPAND "<h"))
;;   ("a" (HOT-EXPAND "<a"))
;;   ("<" SELF-INSERT-COMMAND "INS")
;;   ("O" (PROGN
;;   (HOT-EXPAND "<S")
;;   (insert "org")
;;   (forward-line))))

;; (defun hot-expand (str)
;;   "Expand org template."
;;   (insert str)
;;   (org-try-structure-completion))

;; ;; I bind it for myself like this:

;; (define-key org-mode-map "<"
;;   (lambda () (interactive)
;;      (if (looking-back "^")
;;   (hydra-org-template/body)
;;        (self-insert-command 1))))



(provide 'init-hydra)
