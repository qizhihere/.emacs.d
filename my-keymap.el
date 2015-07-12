(defun lqz/global-set-key (keymap &optional cmd)
  (setf keymap (if (not (listp keymap)) (list keymap cmd) keymap))
    (do ((n 0 (+ n 2)))
    ((> n (- (length keymap) 1)) t)
      (global-set-key (kbd (nth n keymap)) (nth (+ n 1) keymap))))

(setq lqz/keymaps
      '(
    "C-c m l" helm-all-mark-rings
    "C-c u y" xsel-copy
    "C-c u p" xsel-paste
    "C-c u x" xsel-cut
    "C-c C-f" helm-recentf))

(defun lqz/set-evil-keymaps ()
  ;; project related
  (evil-leader/set-key
    "pd"  'helm-projectile-find-dir
    "pf"  'helm-projectile-find-file
    "pg"  'helm-projectile-grep
    "pp"  'helm-projectile-switch-project
    )
  ;; marks related
  (evil-leader/set-key
    "ml"  'helm-bm
    "mm"  'bm-toggle
    "mj"  'bm-next
    "mk"  'bm-previous
    "md"  'bm-remove-all-current-buffer
    "mD"  'bm-remove-all-all-buffers
    )
  (evil-leader/set-key
    "al"  'align-regexp
    "cc"  'evilnc-comment-or-uncomment-lines
    "cu"  'evilnc-comment-or-uncomment-lines
    "cy"	'xsel-copy
    "cp"	'xsel-paste
    "cx"  'xsel-cut
    "df"  'helm-dash
    "dg"  'helm-dash-at-point
    "dr"  'helm-dash-reset-connections
    "el"  'helm-emmet
    "er"  'helm-flycheck
    "ff"	'find-file
    "fe"  'sr-speedbar-toggle
    "gi"  'magit-status
    "lf"  'load-file
    "ot"  'org-insert-todo-heading
    "qa"	'save-buffers-kill-terminal
    "qq"  'delete-window
    "re"	'highlight-symbol-query-replace
    "sh"  'eshell
    "ss"  'helm-do-ag
    "sf"  'helm-ag-this-file
    "su"  'suspend-emacs
    "ti"  'imenu
    "tl"  'helm-semantic-or-imenu
    "un"  'undo-tree-visualize
    "evb" 'eval-buffer
    "evr" 'eval-region
    "evf" 'eval-defun
    "eww"	'eww
    "ewf" 'eww-open-file
    )
  )


(with-eval-after-load 'evil-leader (lqz/set-evil-keymaps))



(lqz/global-set-key lqz/keymaps)



(provide 'my-keymap)
