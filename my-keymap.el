(lqz/require '(comment-dwim-2 swiper smex))

;; a little simple settings
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(define-key dired-mode-map (kbd "M-i") 'swiper)
(define-key ivy-minibuffer-map (kbd "C-o") 'ivy-recentf)
(setq smex-save-file (lqz/init-dir "tmp/smex-items"))

(defun lqz/global-set-key (keymap &optional cmd)
  (setf keymap (if (not (listp keymap)) (list keymap cmd) keymap))
	(do ((n 0 (+ n 2)))
	((> n (- (length keymap) 1)) t)
	  (global-set-key (kbd (nth n keymap)) (nth (+ n 1) keymap))))

(defun highlight-symbol-query-replace (symbol replacement)
  "Replace the SYMBOL with REPLACEMENT.
If no symbol given or not use a region, then the symbol at point
will be used."
  (interactive (let ((symbol (lqz/current-word)))
		 (highlight-symbol-temp-highlight)
		 (set query-replace-to-history-variable
			  (cons (substring-no-properties symbol)
				(eval query-replace-to-history-variable)))
		 (list symbol
		  (read-from-minibuffer (concat "Replace 「" symbol "」 to: ") nil nil nil
					query-replace-to-history-variable))))
  (goto-char (beginning-of-thing 'symbol))
  (query-replace-regexp symbol replacement))

(defun lqz/search-github-code (keywords extension)
  "Search code in GitHub."
  (interactive
   (list
	(read-from-minibuffer "Keywords: " (lqz/current-word))
	(read-from-minibuffer "Extension: ")))
  (browse-url-default-browser
   (concat "https://github.com/search?type=Code&q="
	   keywords "+extension:" extension)))

(defun lqz/search-google (keywords)
  "Search with google."
  (interactive
   (list
	(read-from-minibuffer "Keywords: " (lqz/current-word))))
  (browse-url-default-browser
   (concat "https://www.google.com/#q=" keywords)))

(defun lqz/insert-numbers (start end)
  (interactive "nStart: \nnEnd: ")
  (dolist (ind (number-sequence start end))
	(insert (format "%d\n" ind))))

(defun lqz/json-format ()
  (interactive)
  (save-excursion
	(shell-command-on-region (mark) (point) "python -m json.tool" (buffer-name) t)))

(defun lqz/open-next-line ()
  "Open next line without cursor move."
  (interactive)
  (newline)
  (previous-line)
  (end-of-line))

(defun lqz/open-previous-line ()
  "Open previous line without cursor move."
  (interactive)
  (let ((pos (point))
	(cur-max (point-max)))
	(beginning-of-line)
	(newline)
	(goto-char (+ pos (- (point-max) cur-max)))))

  (setq lqz/keymaps
	'(
	  "C-c m l" helm-all-mark-rings
	  "C-c c y" xcopy
	  "C-c c p" xpaste
	  "C-c c x" xcut
	  "C-c C-f" helm-recentf
	  "C-M-<backspace>" kill-this-buffer
	  "M-n"     next-buffer
	  "M-p"     previous-buffer
	  "S-<return>" lqz/open-next-line
	  "C-<return>" lqz/open-previous-line
	  "M-x" smex
	  "M-i" swiper))
(define-key markdown-mode-map (kbd "M-p") 'previous-buffer)
(define-key markdown-mode-map (kbd "M-n") 'next-buffer)


(global-set-key (kbd "C-<return>") (lambda ()
									 (interactive)
									 ))
(defun lqz/set-evil-keymaps ()
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
	"p!"  'projectile-run-async-shell-command-in-root
	)

  ;; window and workspace(use persp-mode)
  (evil-leader/set-key
	"ww"   'hydra-window/body
	"wl"   'persp-switch
	"wd"   'persp-remove-buffer
	"wD"   'persp-kill
	"wr"   'persp-rename
	"wa"   'persp-add-buffer
	"wA"   'persp-set-buffer
	"wi"   'persp-import
	"wn"   'lqz/persp-next
	"wp"   'lqz/persp-prev
	"ws"   'persp-save-state-to-file
	"wR"   'persp-load-state-from-file)

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
	"sgi"  'lqz/search-github-code
	"sgo"  'lqz/search-google)

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


(global-unset-key (kbd "M-;"))
(global-set-key (kbd "M-;")	 'comment-dwim-2)
(global-set-key [f12]		 'persp-switch)
(global-set-key (kbd "C-S-s")    'phi-search)
(global-set-key (kbd "C-S-r")    'phi-search-backward)
(with-eval-after-load            'evil-leader (lqz/set-evil-keymaps))



(lqz/global-set-key lqz/keymaps)



(provide 'my-keymap)
