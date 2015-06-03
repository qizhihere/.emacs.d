(lqz/require 'guide-key)
(guide-key-mode 1)
(setq guide-key/guide-key-sequence `("C-x"
				     "C-c"
				     "C-w"
				     "C-x r"
				     "C-x 4"
				     "M-m"
				     "C-M-m"
				     ;; M-m in terminal
				     "<ESC>m"
				     ;; C-M-m in terminal
				     "<ESC><RET>"
				     "g"
				     "\["
				     "\]"
				     ";"
				     "z"
				     "C-h")
	  guide-key/recursive-key-sequence-flag t
	  guide-key/popup-window-position 'right
	  guide-key/highlight-command-regexp "rectangle"
	  guide-key/idle-delay 0.7
	  guide-key/text-scale-amount 0
)



(provide 'init-guide-key)
