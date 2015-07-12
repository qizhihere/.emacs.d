(require 'spacegray-theme)

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

(lqz/set-gui-font)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(set-frame-size (selected-frame) 78 26)



(provide 'init-gui)
