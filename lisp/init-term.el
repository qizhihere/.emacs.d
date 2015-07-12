(lqz/require 'zenburn-theme)

;; load theme
(setq lqz/theme 'zenburn)
(load-theme lqz/theme t)

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
)

(defun lqz/set-xterm-faces ()
  (custom-set-faces
   '(git-gutter:added ((t (:background "green" :foreground "#3a3a3a" :inverse-video t :weight bold))))
   '(git-gutter:deleted ((t (:background "red" :foreground "#3a3a3a" :inverse-video t :weight bold))))
   '(git-gutter:modified ((t (:background "yellow" :foreground "#3a3a3a" :inverse-video t :weight bold))))
   '(git-gutter:unchanged ((t (:foreground "#3a3a3a" :inverse-video t :weight bold))))
   '(Man-overstrike ((t (:inherit bold :foreground "color-202"))))
   '(Man-reverse ((t (:inherit highlight :background "color-38" :foreground "color-231"))))
   '(Man-underline ((t (:inherit underline :foreground "color-41"))))
   '(flymake-errline ((t (:background "color-88" :foreground "yellow" :underline (:color foreground-color :style wave) :weight bold))))
   ))

(lqz/set-xterm-faces)


;; map some keys when TERM=screen-256color
(defadvice terminal-init-screen(around lqz/map-terminal-keys activate)
  (map-xterm-escape-sequence)
  ad-do-it)

;; map some keys when TERM=xterm-256color
(defadvice terminal-init-xterm(around lqz/map-terminal-keys activate)
  (map-xterm-escape-sequence)
  ad-do-it)



(provide 'init-term)
