;;----------------------------------------------------------------------------
;; paths and sessions
;;----------------------------------------------------------------------------
(let ((x (my/init-dir "session")))
  (or (file-exists-p x) (mkdir x)))

;; desktop
(setq desktop-dirname             (my/init-dir "session/")
	  desktop-path                (list desktop-dirname)
	  desktop-files-not-to-save   "^$" ;reload tramp path
	  desktop-auto-save-timeout   600)
;; enable desktop save
(desktop-save-mode 1)
(add-hook 'desktop-after-read-hook 'display-startup-echo-area-message)

;; save history
(savehist-mode 1)
(setq history-length 10000
	  savehist-file (my/init-dir "tmp/history"))

(my/install 'session)
(custom-set-variables '(session-save-file (my/init-dir "session/.session")))
(setq session-name-disable-regexp "\\(?:\\`'/tmp\\|\\.pdf\\|\\.git/[A-Z_]+\\'\\)")
(after-init (session-initialize))

(defadvice desktop-read (around my/desktop-read-show-startup-time activate)
  (or (boundp '*start-restore-at*)
	  (setq *start-restore-at* (float-time)))
  ad-do-it)


;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
(setq desktop-globals-to-save
	  (append '((comint-input-ring        . 50)
				(compile-history          . 30)
				desktop-missing-file-warning
				(dired-regexp-history     . 20)
				(extended-command-history . 30)
				(face-name-history        . 20)
				(file-name-history        . 100)
				(grep-find-history        . 30)
				(grep-history             . 30)
				(ido-buffer-history       . 100)
				(ido-last-directory-list  . 100)
				(ido-work-directory-list  . 100)
				(ido-work-file-list       . 100)
				(magit-read-rev-history   . 50)
				(minibuffer-history       . 50)
				(org-clock-history        . 50)
				(org-refile-history       . 50)
				(org-tags-history         . 50)
				(query-replace-history    . 60)
				(read-expression-history  . 60)
				(regexp-history           . 60)
				(regexp-search-ring       . 20)
				register-alist
				(search-ring              . 20)
				(shell-command-history    . 50)
				tags-file-name
				tags-table-list)))



(provide 'init-session)
