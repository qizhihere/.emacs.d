(my/install 'workgroups2)
(after-init
  (after-load 'workgroups2
	(diminish 'workgroups-mode)
	(setq wg-prefix-key (kbd "C-c z")
		  wg-session-file (my/init-dir "session/workgroups")))

  (global-set-key (kbd "<pause>")   'wg-reload-session)
  (global-set-key (kbd "C-<pause>") 'wg-save-session)
  (global-set-key (kbd "M-\\")      'wg-switch-to-workgroup)
  (global-set-key (kbd "M-[")       'wg-switch-to-previous-workgroup)

  (workgroups-mode 1))



(provide 'init-workgroups2)
