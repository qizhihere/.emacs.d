(lqz/require 'spacegray-theme)

;; load theme
(setq lqz/theme 'spacegray)
(load-theme lqz/theme t)

;; set gui font
(defun lqz/set-gui-font ()
  (interactive)
  (set-face-attribute
   'default nil :font "Source Code Pro For Powerline 12")
  (set-fontset-font
   (frame-parameter nil 'font)
   'han
   (font-spec :family "WenQuanYi Micro Hei Regular" :size 12)))

(defun lqz/set-gui-faces ()
  (custom-set-faces
   '(Man-overstrike ((t (:inherit bold :foreground "#ff5f00"))))
   '(Man-reverse ((t (:inherit highlight :background "#00afd7" :foreground "color-231"))))
   '(Man-underline ((t (:inherit underline :foreground "#00d75f"))))
   '(linum-relative-current-face ((t (:inherit linum :foreground "#CAE682" :weight bold))))
   '(git-gutter:added ((t (:background "green" :foreground "#2B303B" :inverse-video t :weight bold))))
   '(git-gutter:deleted ((t (:background "red" :foreground "#2B303B" :inverse-video t :weight bold))))
   '(git-gutter:modified ((t (:background "yellow" :foreground "#2B303B" :inverse-video t :weight bold))))
   '(git-gutter:unchanged ((t (:foreground "#2B303B" :inverse-video t :weight bold))))
   '(magit-section-highlight ((t (:background "#343d46"))))
   '(custom-button ((t (:background "#343d46" :foreground "#111111" :box (:line-width 1 :color "#4f5b67")))))
   '(helm-candidate-number ((t (:background "#1c1f26" :foreground "#b4eb89"))))
   '(helm-header ((t (:inherit header-line :background "#2B303B"))))
   '(helm-match ((t (:background "#343d46" :foreground "#ffffff" :weight bold))))
   '(helm-selection ((t (:background "#343d46" :distant-foreground "black"))))
   '(helm-source-header ((t (:background "#1c1f26" :foreground "white" :weight semi-bold))))
   '(sml/col-number ((t (:inherit sml/global))))
   '(sml/filename ((t (:inherit mode-line-buffer-id :weight normal))))
   '(sml/global ((t (:inherit font-lock-preprocessor-face :foreground "#438bfd"))))
   '(sml/line-number ((t (:inherit sml/modes))))
   '(sml/modified ((t (:inherit sml/not-modified :foreground "Red" :weight bold))))
   '(sml/not-modified ((t (:inherit sml/col-number))))
   '(widget-button ((((class color) (min-colors 89)) (:underline t))))
   '(widget-field ((((class color) (min-colors 89)) (:background "#343d46" :box (:line-width 1 :color "#ffffff")))))
   '(window-numbering-face ((t (:foreground "#218b22"))) t)
   ))

(lqz/set-gui-font)
(lqz/set-gui-faces)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(set-frame-size (selected-frame) 78 26)



(provide 'init-gui)
