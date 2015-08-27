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

  (defun my/wg-create-workgroup ()
    (interactive)
    (with-temp-advice
     'wg-make-and-add-workgroup
     (call-interactively #'wg-create-workgroup)))

  (defadvice wg-switch-to-workgroup (around my/wg-switch-to-new-empty activate)
    (with-temp-advice
     'wg-make-and-add-workgroup
     ad-do-it))

  (defadvice wg-auto-associate-buffer (around my/wg-special-buffer-patch activate)
    "Patch to ignore special buffers such as company-mode completion buffer."
    (when wg-buffer-auto-association-on
      (-when-let* ((wg (wg-current-workgroup t frame))
                   (b (get-buffer buffer)))
        (message "1111")
        (unless (or (wg-workgroup-bufobj-association-type wg buffer)
                    (member wg wg-deactivation-list)
                    (string-match-p "^*temp" (buffer-name b))
                    (member (buffer-name b) wg-associate-blacklist)
                    (not (or (buffer-file-name b)
                             (eq (buffer-local-value 'major-mode b) 'dired-mode))))
          (message "2222")
          (wg-auto-associate-buffer-helper
           wg buffer (wg-local-value 'wg-buffer-auto-association wg))))))
  )

(custom-set-default 'wg-first-wg-name "All")

(global-set-key (kbd "C-<pause>") 'wg-reload-session)
(global-set-key (kbd "<pause>")   'wg-save-session)
(when *is-gui*
  (global-set-key (kbd "M-\\")      'wg-switch-to-workgroup)
  (global-set-key (kbd "M-[")       'wg-switch-to-previous-workgroup)
  (global-set-key (kbd "M-]")       'wg-switch-to-previous-workgroup))

(after-init (workgroups-mode 1))


(provide 'init-workgroups2)
