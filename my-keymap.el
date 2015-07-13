(lqz/require 'comment-dwim-2)

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
  ;; basic
  (define-key evil-insert-state-map (kbd "C-n") 'next-line)
  (define-key evil-insert-state-map (kbd "C-p") 'previous-line)
  (define-key evil-insert-state-map (kbd "C-e") 'end-of-line)

  ;; project related
  (evil-leader/set-key
    "pd"  'helm-projectile-find-dir
    "pf"  'helm-projectile-find-file
    "pg"  'helm-projectile-grep
    "pp"  'helm-projectile-switch-project)

  ;; mark related
  (evil-leader/set-key
    "ml"  'helm-bm
    "mm"  'bm-toggle
    "mj"  'bm-next
    "mk"  'bm-previous
    "md"  'bm-remove-all-current-buffer
    "mD"  'bm-remove-all-all-buffers)

  ;; outline minor mode
  (evil-leader/set-key
    ;; hide
    "oha"  'outline-hide-sublevels
    "ohb"  'outline-hide-body
    "ohe"  'outline-hide-entry
    "ohs"  'outline-hide-subtree
    "ohh"  'outline-hide-subtree
    "ohl"  'outline-hide-leaves
    ;; show
    "osa"  'outline-show-all
    "ose"  'outline-show-entry
    "osb"  'outline-show-branches
    "osc"  'outline-show-children
    "oss"  'outline-show-subtree
    )

  (evil-leader/set-key
    "al"  'align-regexp
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


(global-set-key (kbd "M-'")	'comment-dwim-2)
(with-eval-after-load 'evil-leader (lqz/set-evil-keymaps))



(lqz/global-set-key lqz/keymaps)



(provide 'my-keymap)
