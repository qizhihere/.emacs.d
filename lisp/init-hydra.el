(my/install '(hydra org))

(global-set-key [f2] 'hydra-menu/body)
(defhydra hydra-menu (:color blue :hint nil)
  "Select a submenu"
  ("w" (hydra-window/body) "window")
  ("z" hydra-zoom/body "zoom")
  ("o" hydra-org/body "org")
  ("q" nil "quit" :exit t))


;; text zoom
(defhydra hydra-zoom (:color red)
  "zoom"
  ("+" text-scale-increase "in")
  ("-" text-scale-decrease "out")
  ("q" nil "quit" :exit t))

(global-set-key (kbd "C-x w") 'hydra-window/body)
(defhydra hydra-window (:hint nil)
  "
Split:  _v_/_s_ ⿰/⿱     _d_/_D_ delete window / other windows
Adjust: _}_/_{_ ↔+/-    ↕ _+_/_-_    _=_ balance      [_q_] quit
"
  ("v" split-window-right)
  ("s" split-window-below)
  ("d" delete-window)
  ("D" delete-other-windows)

  ("}" enlarge-window-horizontally)
  ("{" shrink-window-horizontally)
  ("+" enlarge-window)
  ("-" shrink-window)
  ("=" balance-windows)

  ;; undo/redo
  ("u" winner-undo)
  ("r" winner-redo)

  ;; window switch
  ("h" windmove-left)
  ("j" windmove-down)
  ("k" windmove-up)
  ("l" windmove-right)

  ("q" nil :exit t))


(after-load 'org (define-key org-mode-map (kbd "M-o") 'hydra-org/body))
(defhydra hydra-org (:exit t :foreign-keys run :hint nil)
  "
Press:   [_p_/_n_/_P_/_N_] prev/next heading  [_i_]nsert  [_e_]xport  [_q_]uit
"
  ;; navigate
  ("p" outline-previous-visible-heading :exit nil)
  ("n" outline-next-visible-heading :exit nil)
  ("P" org-backward-heading-same-level :exit nil)
  ("N" org-forward-heading-same-level :exit nil)
  ("^" org-up-element :exit nil)

  ;; publish
  ("e" hydra-org-export/body)

  ;; insert snippets
  ("i" my/helm-org-snippets)

  ("q" nil :exit t))


(defhydra hydra-org-export (:exit t :hint nil)
  "
Export: [_h_]tml  [_m_]arkdown  [_a_]scii  [_u_]tf8
"
  ("h" org-publish-current-file)
  ("m" org-md-export-to-markdown)
  ("a" org-ascii-export-to-ascii)
  ("u" org-html-export-to-html))



(provide 'init-hydra)
