(lqz/require '(chinese-pyim pos-tip))

(setq default-input-method "chinese-pyim")

(setq pyim-use-tooltip t)
(setq pyim-dicts-manager-scel2pyim-command (lqz/init-dir "utils/bin/scel2pyim"))
(global-set-key (kbd "C-M-<SPC>") 'toggle-input-method)
(global-set-key (kbd "C-;") 'pyim-toggle-full-width-punctuation)


(provide 'init-input-method)
