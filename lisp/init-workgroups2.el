(my/install 'workgroups2)

(after-load 'workgroups
  (diminish 'workgroups-mode)
  (setq wg-prefix-key (kbd "C-c z")
		wg-session-file (my/init-dir "session/workgroups")
		wg-mess-with-buffer-list t))

(global-set-key (kbd "<pause>")   'wg-reload-session)
(global-set-key (kbd "C-<pause>") 'wg-save-session)
(global-set-key (kbd "M-\\")      'wg-switch-to-workgroup)
(global-set-key (kbd "M-[")       'wg-switch-to-previous-workgroup)

(after-init (workgroups-mode 1))


(provide 'init-workgroups2)
