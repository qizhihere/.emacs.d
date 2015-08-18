(my/install 'workgroups2)

(add-hook 'workgroups-mode-hook
		  (lambda () (diminish 'workgroups-mode)
			(setq wg-prefix-key (kbd "C-c w")
				  wg-session-file (my/init-dir "session/workgroups")
				  wg-mess-with-buffer-list t)))

(after-load 'workgroups2
  (defadvice wg-barf-on-active-minibuffer
	  (around my/wg-barf-on-active-minibuffer activate)
	(when (wg-minibuffer-inactive-p)
	  ad-do-it)))

(global-set-key (kbd "C-<pause>") 'wg-reload-session)
(global-set-key (kbd "<pause>")   'wg-save-session)
(global-set-key (kbd "M-\\")      'wg-switch-to-workgroup)
(global-set-key (kbd "M-[")       'wg-switch-to-previous-workgroup)
(global-set-key (kbd "M-]")       'wg-switch-to-previous-workgroup)

(after-init (workgroups-mode 1))


(provide 'init-workgroups2)
