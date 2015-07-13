(require 'spacegray-theme)

;; load theme
(setq lqz/theme 'spacegray)
(load-theme lqz/theme t)

;; set gui font

;; English font
(set-face-attribute
 'default nil :font "Source Code Pro For Powerline 12")
;; Chinese font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "WenQuanYi Micro Hei Mono Regular" :size 12)))

;; font scale shortcut key
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C-=") 'text-scale-decrease)
;; For Linux
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)
;; For Windows
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; hide bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; set default window size
(set-frame-size (selected-frame) 78 26)



(provide 'init-gui)
