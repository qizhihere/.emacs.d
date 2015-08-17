;;----------------------------------------------------------------------------
;; load theme
;;----------------------------------------------------------------------------
(require 'spacegray-theme)
(setq my/current-theme 'spacegray)
(load-theme my/current-theme t)


;;----------------------------------------------------------------------------
;; set gui font
;;----------------------------------------------------------------------------
;; English font
(set-face-attribute
 'default nil :font "Source Code Pro For Powerline 12")
;; Chinese font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
					charset
					(font-spec :family "WenQuanYi Micro Hei Mono" :size 17)))

;; (setq face-font-rescale-alist '(("Source Code Pro for Powerline 14" . 1.0) ("文泉驿等宽微米黑" . 1.28)))

;; specify font for all unicode characters
(when (member "Symbola" (font-family-list))
  (set-fontset-font t 'unicode "Symbola" nil 'prepend))

;; set Unicode data file location. (used by what-cursor-position and describe-char)
(let ((x (my/init-dir "configs/UnicodeData.txt")))
  (when (file-exists-p x)
	(setq describe-char-unicodedata-file x)))

;; For Linux
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)

(setq use-file-dialog nil
	  use-dialog-box nil)

;; set default window size
(set-frame-size (selected-frame) 78 26)
(set-window-fringes (selected-window) 15 0)



(provide 'init-gui)
