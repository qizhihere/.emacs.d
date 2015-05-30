;; set gui font
(defun set-gui-font()
  (interactive)
  (set-face-attribute
   'default nil :font "Source Code Pro For Powerline 12")
  (set-fontset-font
   (frame-parameter nil 'font)
   'han
   (font-spec :family "WenQuanYi Micro Hei Regular" :size 12)))

(set-gui-font)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-frame-size (selected-frame) 78 26)



(provide 'init-gui)
