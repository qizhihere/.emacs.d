(lqz/require '(chinese-pyim pos-tip))

(setq default-input-method "chinese-pyim")

(setq pyim-use-tooltip t)
(global-set-key (kbd "C-M-<SPC>") 'toggle-input-method)
(global-set-key (kbd "C-;") 'pyim-toggle-full-width-punctuation)


(provide 'init-input-method)
