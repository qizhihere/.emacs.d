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

  ;; file and directory related
  (evil-leader/set-key
    "ff"  'find-file
    "fs"  'fiplr-find-file
    "fg"  'helm-do-grep
    "df"  'dired
    "ds"  'fiplr-find-directory)

  ;; project related
  (evil-leader/set-key
    "pb"  'helm-projectile-switch-to-buffer
    "pk"  'projectile-kill-buffers
    "pd"  'helm-projectile-find-dir
    "pD"  'projectile-dired
    "pf"  'helm-projectile-find-file
    "pF"  'helm-projectile-recentf
    "pg"  'helm-projectile-grep
    "pp"  'projectile-persp-switch-project
    "pl"  'projectile-persp-switch-project
    "pP"  'helm-projectile-switch-project
    "po"  'projectile-multi-occur
    "ps"  'helm-projectile-ag
    "pc"  'projectile-commander
    "pr"  'projectile-replace
    "pt"  'projectile-regenerate-tags
    "p!"  'projectile-run-async-shell-command-in-root
  )

  ;; window and workspace(use perspective)
  (evil-leader/set-key
    "ww"   'hydra-window/body
    "wl"   'persp-switch
    "wb"   'persp-switch-to-buffer
    "wd"   'persp-remove-buffer
    "wD"   'persp-kill
    "wr"   'persp-rename
    "wa"   'persp-add-buffer
    "wA"   'persp-set-buffer
    "wi"   'persp-import
    "wn"   'persp-next
    "wp"   'persp-prev
    )

  ;; mark related
  (evil-leader/set-key
    "ml"  'helm-bm
    "mm"  'bm-toggle
    "mn"  'bm-next
    "mp"  'bm-previous
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

  ;; version control
  (evil-leader/set-key
    "vd"  'vc-diff
    "vh"  'vc-annotate
    "vl"  'vc-print-log
    "vr"  'vc-revert
    "vm"  'vc-merge)

  ;; git related
  (evil-leader/set-key
    "gi" 'magit-status
    "ggn" 'git-gutter:next-hunk
    "ggp" 'git-gutter:previous-hunk
    "ggs" 'git-gutter:stage-hunk
    "ggr" 'git-gutter:revert-hunk
    "gt"  'git-timemachine-toggle
    )

  ;; clipboard related
  (evil-leader/set-key
    "cy"  'xsel-copy
    "cp"  'xsel-paste
    "cx"  'xsel-cut)

  ;; helm
  (evil-leader/set-key
    "hi"  'helm-semantic-or-imenu
    "hI"  'helm-imenu-in-all-buffers
    "hr"  'helm-regexp
    "ho"  'helm-occur)

  ;; eval
  (evil-leader/set-key
    "evb" 'eval-buffer
    "evr" 'eval-region
    "evf" 'eval-defun)

  ;; register
  (evil-leader/set-key
    "rw"  'window-configuration-to-register
    "rf"  'frame-configuration-to-register
    "rs"  'copy-to-register
    "rj"  'jump-to-register
    )

  ;; in-buffer search
  (evil-leader/set-key
    "ss"  'phi-search
    "sr"  'phi-search-backward
    "C-s" 'phi-search
    "C-r" 'phi-search-backward
    )

  ;; others
  (evil-leader/set-key
    "al"  'align-regexp
    "er"  'helm-flycheck
    "el"  'helm-emmet
    "eww" 'eww
    "ewf" 'eww-open-file
    "re"  'highlight-symbol-query-replace
    "sh"  'eshell
    "un"  'undo-tree-visualize)
  )


(global-set-key (kbd "M-'")	'comment-dwim-2)
(global-set-key [f12]	'persp-switch)
(global-set-key (kbd "C-S-s") 'phi-search)
(global-set-key (kbd "C-S-r") 'phi-search-backward)
(with-eval-after-load 'evil-leader (lqz/set-evil-keymaps))



(lqz/global-set-key lqz/keymaps)



(provide 'my-keymap)
