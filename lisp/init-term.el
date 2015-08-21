(my/install '(spacemacs-theme color-theme-sanityinc-solarized))

;; load theme
(setq my/current-theme 'spacemacs-dark)
(load-theme my/current-theme t)

(after-load 'color-theme-sanityinc-solarized
  (custom-set-faces
   '(show-paren-match ((t (:underline t :inherit highlight :inverse-video nil))))
   '(highlight-symbol-face ((t (:inherit highlight))))
   '(linum-relative-current-face ((t (:inherit linum :foreground "#5F8787" :weight bold))))))

(after-load 'spacemacs-dark-theme
  (custom-set-faces
   '(highlight-symbol-face ((t (:background "#2c2c2c"))))))

;; enable mouse mode
(xterm-mouse-mode t)

;; Reference url: http://emacswiki.org/emacs/PuTTY
(defun map-xterm-escape-sequence ()
  (interactive)

  ;; shift map
  (define-key input-decode-map "\e[1;2A" [S-up])
  (define-key input-decode-map "\e[1;2B" [S-down])
  (define-key input-decode-map "\e[1;2C" [S-right])
  (define-key input-decode-map "\e[1;2D" [S-left])
  (define-key input-decode-map "\e[1;2H" [S-home])
  (define-key input-decode-map "\e[1;2F" [S-end])
  (define-key input-decode-map "\e[5;2~" [S-prior])
  (define-key input-decode-map "\e[6;2~" [S-next])

  ;; alt/meta map
  (define-key input-decode-map "\e[1;3A" [M-up])
  (define-key input-decode-map "\e[1;3B" [M-down])
  (define-key input-decode-map "\e[1;3D" [M-left])
  (define-key input-decode-map "\e[1;3C" [M-right])
  ;; map <C-M-j> to <M-return>
  (define-key input-decode-map "\e\C-j" [M-return])

  ;; alt+shift map
  (define-key input-decode-map "\e[1;4A" [M-S-up])
  (define-key input-decode-map "\e[1;4B" [M-S-down])
  (define-key input-decode-map "\e[1;4D" [M-S-left])
  (define-key input-decode-map "\e[1;4C" [M-S-right])

  ;; control map
  (define-key input-decode-map "\e[1;5A" [C-up])
  (define-key input-decode-map "\e[1;5B" [C-down])
  (define-key input-decode-map "\e[1;5C" [C-right])
  (define-key input-decode-map "\e[1;5D" [C-left])

  ;; control+shift map
  (define-key input-decode-map "\e[1;6A" [C-S-up])
  (define-key input-decode-map "\e[1;6B" [C-S-down])
  (define-key input-decode-map "\e[1;6C" [C-S-right])
  (define-key input-decode-map "\e[1;6D" [C-S-left])

  ;; home/end/pageup/pagedown etc
  (define-key input-decode-map "\e[1~" [home])
  (define-key input-decode-map "\e[4~" [end])
  (define-key input-decode-map "\e[5~" [prior])
  (define-key input-decode-map "\e[6~" [next])
  )

;; map some keys when TERM=screen-256color
(defadvice terminal-init-screen (around my/map-terminal-keys activate)
  (map-xterm-escape-sequence)
  ad-do-it)

;; map some keys when TERM=xterm-256color
(defadvice terminal-init-xterm (around my/map-terminal-keys activate)
  (map-xterm-escape-sequence)
  ad-do-it)



(provide 'init-term)
