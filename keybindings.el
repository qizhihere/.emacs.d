(my/install 'comment-dwim-2)
(my/install '(expand-region move-dup))

;; quick switch window
(my/install 'window-numbering)
(defadvice window-numbering-get-number-string (around my/window-numbering-get-number-string
                                                      (&optional window) activate)
  (let ((s (concat " [" (concat (int-to-string (window-numbering-get-number window)) "]"))))
    (propertize s 'face 'window-numbering-face)))
(after-init (window-numbering-mode 1))

(defun other-window-move-down(&optional arg)
  "Other window move-down 2 lines."
  (interactive "p")
  (scroll-other-window 2))

(defun other-window-move-up(&optional arg)
  "Other window move-down 2 lines."
  (interactive "P")
  (if arg
      (scroll-other-window-down arg)
    (scroll-other-window-down 2)))

(defun my/insert-numbers (start end)
  (interactive "nStart: \nnEnd: ")
  (dolist (ind (number-sequence start end))
    (insert (format "%d\n" ind))))

(defun my/json-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region (mark) (point) "python -m json.tool" (buffer-name) t)))

(defun my/open-next-line ()
  "Open next line without cursor move."
  (interactive)
  (newline)
  (previous-line)
  (end-of-line))

(defun my/open-previous-line ()
  "Open previous line without cursor move."
  (interactive)
  (let ((pos (point))
        (cur-max (point-max)))
    (beginning-of-line)
    (newline)
    (goto-char (+ pos (- (point-max) cur-max)))))

;; set global keys
(dolist (x '("M-;" "C-x c"))
  (global-unset-key (kbd x)))
(dolist (x '(("M-<up>" md/move-lines-up)
             ("M-<down>" md/move-lines-down)
             ("C-M-<up>" md/duplicate-up)
             ("C-M-<down>" md/duplicate-down)
             ("C-c m l" helm-all-mark-rings)
             ("C-c c y" xcopy)
             ("C-c c p" xpaste)
             ("C-c c x" xcut)
             ("S-<insert>" xpaste)
             ("S-<delete>" xcut)
             ("C-c C-f" helm-recentf)
             ("C-M-<backspace>" kill-this-buffer)
             ("M-n"     next-buffer)
             ("M-p"     previous-buffer)
             ("S-<return>" my/open-next-line)
             ("C-<return>" my/open-previous-line)
             ("M-x" smex)
             ("M-i" swiper)
             ("C-=" er/expand-region)
             ("M-;" comment-dwim-2)
             ("RET" newline-and-indent)
             ("C-M-v" other-window-move-down)
             ("C-M-b" other-window-move-up)))
  (global-set-key (kbd (car x)) (cadr x)))

(after-load "evil-leader"
  ;; file and directory related
  (evil-leader/set-key
    "ff"  'find-file
    "fs"  'fiplr-find-file
    "fg"  'helm-do-grep
    "df"  'dired
    "ds"  'fiplr-find-directory)

  ;; buffer related
  (evil-leader/set-key
    ";"  'ivy-switch-buffer)

  ;; project related
  (evil-leader/set-key
    "pb"  'helm-projectile-switch-to-buffer
    "pk"  'projectile-kill-buffers
    "pd"  'helm-projectile-find-dir
    "pD"  'projectile-dired
    "pf"  'helm-projectile-find-file
    "pF"  'helm-projectile-recentf
    "pg"  'helm-projectile-grep
    "pp"  'helm-projectile-switch-project
    "po"  'projectile-multi-occur
    "ps"  'helm-projectile-ag
    "pc"  'projectile-commander
    "pr"  'projectile-replace
    "pt"  'projectile-regenerate-tags
    "p!"  'projectile-run-async-shell-command-in-root)

  ;; window and workspace(use workgroups2)
  (evil-leader/set-key
    "ww"   'hydra-window/body
    "wl"   'wg-switch-to-workgroup
    "wd"   'wg-kill-workgroup-and-buffers
    "wD"   'wg-delete-other-workgroups
    "wc"   'my/wg-create-workgroup
    "wC"   'wg-clone-workgroup
    "wr"   'wg-rename-workgroup
    "wR"   'wg-revert-workgroup
    "wn"   'wg-switch-to-workgroup-right
    "wp"   'wg-switch-to-workgroup-left
    "wi"   'wg-open-session
    "wo"   'wg-open-session
    "ws"   'wg-save-session
    "wS"   'wg-save-session-as)

  ;; mark related
  (evil-leader/set-key
    "ml"  'helm-bm
    "mm"  'bm-toggle
    "mn"  'bm-next
    "mp"  'bm-previous
    "md"  'bm-toggle
    "mD"  'bm-remove-all-current-buffers
    "mR"  'bm-remove-all-all-buffers)

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
    "oss"  'outline-show-subtree)

  ;; version control
  (evil-leader/set-key
    "vd"  'vc-diff
    "vh"  'vc-annotate
    "vl"  'vc-print-log
    "vr"  'vc-revert
    "vm"  'vc-merge)

  ;; git related
  (evil-leader/set-key
    "gis" 'magit-status
    "gii" 'magit-status
    "gil" 'magit-log-current
    "gir" 'magit-reflog-current
    "ggn" 'git-gutter:next-hunk
    "ggp" 'git-gutter:previous-hunk
    "ggs" 'git-gutter:stage-hunk
    "ggr" 'git-gutter:revert-hunk
    "git"  'git-timemachine-toggle)

  ;; clipboard related
  (evil-leader/set-key
    "cy"  'xcopy
    "cp"  'xpaste
    "cx"  'xcut)

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

  ;; emms
  (evil-leader/set-key
    "emm" 'emms-playlist-mode-go
    "emn" 'emms-next
    "emp" 'emms-previous
    "emP" 'emms-pause
    "emR" 'emms-toggle-random-playlist
    "em+" 'emms-volume-mode-plus
    "em-" 'emms-volume-mode-minus)

  ;; register
  (evil-leader/set-key
    "rw"  'window-configuration-to-register
    "rf"  'frame-configuration-to-register
    "rs"  'copy-to-register
    "rj"  'jump-to-register
    "rl"  'helm-register)

  ;; search related
  (evil-leader/set-key
    "ag"  'ag
    "hag" 'helm-ag
    "gr"  'grep
    "gf"  'grep-find
    "sgi"  'my/search-github-code
    "sgo"  'my/search-google)

  ;; yasnippet
  (evil-leader/set-key
    "ysf" 'yas-visit-snippet-file
    "ysn" 'yas-new-snippet
    "ysR" 'yas-reload-all)

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



(provide 'keybindings)
