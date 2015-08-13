(my/install '(hydra org))

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


(after-load "org"
			(define-key org-mode-map (kbd "M-o") 'hydra-org/body))
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
  ("eh" org-publish-current-file)
  ("em" org-md-export-to-markdown :exit nil)
  ("ea" org-ascii-export-to-ascii :exit nil)
  ("eu" org-html-export-to-html :exit nil)

  ;; return to main org menu
  ("m" hydra-org/body)
)


(defhydra hydra-org-insert (:color blue
								   :hint   nil)
  "
_HE_ADER     _TI_TLE      _AU_THOR   _OP_TIONS
_ST_ARTUP    C_EN_TER     _Q_UOTE    _EX_AMPLE
_Me_ta       _NA_ME       _ch_eckbox _TO_DO
_SR_C        _fo_otnote   _Fo_otnote definition
_ti_mestamp  _DA_TE

_li_sp       _em_acs-lisp _C_        C_+_+
_py_thon2    _ph_p        _ng_inx    _sh_ell
_js_         _ht_ml       _cs_s      _sa_ss
_co_ffee     _lu_a

_IM_G        _L_ink       _d_rawer   colu_mn_
L_a_tex      _O_rg        _VE_RSE    COM_ME_NT
I_NC_LUDE    I_ND_EX      _MA_CRO    _HT_ML
_VI_DEO      _SP_ACE(​)

[_m_] return to main org menu
"
  ("HE" (progn
		  (insert (concat "#+TITLE: \n"
						  "#+DESCRIPTION: \n"
						  "#+KEYWORDS: \n"
						  "#+AUTHOR: littleqz\n"
						  "#+EMAIL: qizhihere@gmail.com\n"
						  "#+DATE: <" (format-time-string "%Y-%m-%d %b %H:%M") ">\n"
						  "#+STARTUP: indent hideblocks content\n"
						  "#+OPTIONS: ^:{} toc:nil\n"
						  "#+SETUPFILE: ~/org/layouts/blog.setup\n"))
		  (previous-line 9)
		  (evil-append-line 1)))
  ("TI" (insert "#+TITLE: "))
  ("AU" (insert "#+AUTHOR: littleqz"))
  ("OP" (insert "#+OPTIONS: ^:{} toc:2"))

  ("ST" (progn
		  (insert "#+STARTUP: ")))
  ("EN" (hot-expand "<c"))
  ("Q" (hot-expand "<q"))
  ("EX" (hot-expand "<e"))

  ("Me" (insert "#+CAPTION: \n#+NAME:\t"))
  ("NA" (insert "#+NAME: "))
  ("ch" (progn
		  (org-meta-return)
		  (insert "[ ] ")))
  ("TO" (org-insert-todo-heading))

  ("SR" (hot-expand "<s"))
  ("fo" (progn
		 (insert (concat "[fn::]"))
		 (backward-char)))
  ("Fo" (org-footnote-action))

  ("ti" (insert (concat "<" (format-time-string "%Y-%m-%d %b %H:%M") ">")))
  ("DA" (call-interactively 'org-time-stamp))

  ("li" (insert-src "lisp"))
  ("em" (insert-src "emacs-lisp"))
  ("C"  (insert-src "C"))
  ("+"  (insert-src "cpp"))

  ("py" (insert-src "python2"))
  ("ph" (insert-src "php"))
  ("ng" (insert-src "nginx"))
  ("sh" (insert-src "sh :shebang #!/usr/bin/env bash"))

  ("js" (insert-src "js"))
  ("ht" (insert-src "html"))
  ("cs" (insert-src "css"))
  ("sa" (insert-src "sass"))

  ("co" (insert-src "coffee"))

  ("lu" (insert-src "lua"))

  ("IM" (progn
		(let ((file (file-relative-name
				(read-file-name "Select an image:") default-directory)))
		(insert (concat "[[" file "]]")))))
  ("L" org-insert-link)
  ("d" org-insert-drawer)
  ("mn" org-insert-columns-dblock)

  ("a" (hot-expand "<L"))
  ("O" (progn
		  (hot-expand "<s")
		  (insert "org")
		  (forward-line)
		  (org-edit-src-code)))
  ("VE" (hot-expand "<v"))
  ("ME" (progn
		(next-line)
		(beginning-of-line)
		(insert "#+BEGIN_COMMENT\n\n#+END_COMMENT"
		(previous-line))))

  ("NC" (hot-expand "<I"))
  ("ND" (hot-expand "<i"))
  ("MA" (insert "#+MACRO: "))
  ("HT" (hot-expand "<h"))

  ("VI" (progn
		   (let ((file
					 (concat "http://v.sudotry.com/"
						(file-name-nondirectory
						(my/select-file "Select an video: " "~/sync/Dropbox/video/")))))
		   (insert (concat
			  "#+BEGIN_HTML \n"
				"<video autoplay loop>\n"
				 "\t<source src='" file "' type='video/mp4'/>\n"
				 "\tYour browser does not support the video tag.\n"
				"</video>\n"
			  "#+END_HTML")))))

  ("SP" (insert "\u200B"))

  ("<" self-insert-command "INS")
  ("q" nil)

  ;; return to main org menu
  ("m" hydra-org/body))

(defun insert-src (lang)
  "insert source code."
  (progn
	(hot-expand "<s")
	(insert lang)
	(forward-line)
	(my/send-keys "C-c e i")))

(defun hot-expand (str)
  "expand org template."
  (insert str)
  (org-try-structure-completion))




(provide 'init-hydra)
