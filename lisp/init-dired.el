(my/install '(dired+ dired-efap dired-filter diff-hl))

;; execute actions asynchronously
(autoload 'dired-async-mode "dired-async" nil t)

(after-load 'dired
  (require 'dired+)
  ;; enable async work
  (when (my/try-install'async)
	(dired-async-mode 1))

  ;; use the directory in the next dired window as default directory
  (setq dired-dwim-target t)

  ;; dired rename and filter
  (define-key dired-mode-map (kbd "r") 'dired-efap)
  (define-key dired-mode-map (kbd "F") dired-filter-map)

  (add-hook 'dired-mode-hook
			(lambda ()
			  (guide-key/add-local-guide-key-sequence "%")
			  ;; make dired only use single buffer
			  (toggle-diredp-find-file-reuse-dir 1))))

(when (my/try-install 'diff-hl)
  (after-load 'dired
	(add-hook 'dired-mode-hook 'diff-hl-dired-mode)))


(provide 'init-dired)
