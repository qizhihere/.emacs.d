(my/install 'guide-key)
(after-init
  (guide-key-mode 1)
  (diminish 'guide-key-mode)
  (setq guide-key/guide-key-sequence
		`("C-x"
		  "C-c"
		  "C-w"
		  "C-x r"
		  "C-x 4"
		  "M-m"
		  "M-r"
		  "C-M-m"
		  ;; M-m in terminal
		  "<ESC>m"
		  "<ESC>r"
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
		guide-key/idle-delay 1
		guide-key/text-scale-amount 0))


(provide 'init-guide-key)
