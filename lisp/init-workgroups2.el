(my/install 'workgroups2)

(add-hook 'workgroups-mode-hook
          (lambda () (diminish 'workgroups-mode)
            (setq wg-prefix-key (kbd "C-c w")
                  wg-session-file (my/init-dir "session/workgroups")
                  wg-mess-with-buffer-list t
                  wg-mode-line-decor-left-brace ""
                  wg-mode-line-decor-right-brace ""
                  wg-modeline-string ""
                  wg-mode-line-display-on nil)))

(after-load 'workgroups2
  (defadvice wg-barf-on-active-minibuffer
      (around my/wg-barf-on-active-minibuffer activate)
    (when (wg-minibuffer-inactive-p)
      ad-do-it))

  (defadvice wg-make-and-add-workgroup
      (around my/wg-new-blank-workgroup (name &optional blank))
    "Create new empty workgroup without keeping current buffers."
    (setq blank t)
    ad-do-it)

  (defadvice wg-switch-to-workgroup (around mytest activate)
    (ad-activate #'wg-make-and-add-workgroup)
    ad-do-it
    (ad-deactivate #'wg-make-and-add-workgroup)))

(custom-set-default 'wg-first-wg-name "All")

(global-set-key (kbd "C-<pause>") 'wg-reload-session)
(global-set-key (kbd "<pause>")   'wg-save-session)
(when *is-gui*
  (global-set-key (kbd "M-\\")      'wg-switch-to-workgroup)
  (global-set-key (kbd "M-[")       'wg-switch-to-previous-workgroup)
  (global-set-key (kbd "M-]")       'wg-switch-to-previous-workgroup))

(after-init (workgroups-mode 1))


(provide 'init-workgroups2)
