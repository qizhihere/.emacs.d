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


(after-load 'org (define-key org-mode-map [M-o] 'hydra-org/body))
(defhydra hydra-org (:exit nil :foreign-keys run :hint nil)
  "
Move:   [_p_/_n_/_P_/_N_]   prev/next (same) heading
Export: [_eh_] html  [_em_] markdown  [_ea_] ascii  [_eu_] utf8
Others: [_i_] insert [_q_] quit
"
  ;; navigate
  ("p" outline-previous-visible-heading)
  ("n" outline-next-visible-heading)
  ("P" org-backward-heading-same-level)
  ("N" org-forward-heading-same-level)
  ("^" org-up-element)

  ;; publish
  ("eh" org-publish-current-file)
  ("em" org-md-export-to-markdown)
  ("ea" org-ascii-export-to-ascii)
  ("eu" org-html-export-to-html)

  ;; insert snippets
  ("i" my/helm-org-snippets)

  ("q" nil :exit t))



(provide 'init-hydra)
