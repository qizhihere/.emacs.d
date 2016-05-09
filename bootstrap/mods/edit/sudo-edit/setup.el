(setq sudo-edit-packages '(sudo-edit
                           dired-toggle-sudo))

(defun sudo-edit/init ()
  (use-package sudo-edit
    :leader ("tfs" sudo-edit-current-file
             "ofs"  sudo-edit)))

(defun sudo-edit/init-dired ()
  (loaded dired
    (m|unbind-key "t" dired-mode-map :if #'commandp)
    (bind-key "tt" 'dired-toggle-marks dired-mode-map))

  (use-package dired-toggle-sudo
    :bind (:map dired-mode-map
           ("ts" . dired-toggle-sudo))
    :config
    (loaded tramp
      (add-to-list 'tramp-default-proxies-alist
                   '(".*" "\\`.+\\'" "/ssh:%h:")))))
