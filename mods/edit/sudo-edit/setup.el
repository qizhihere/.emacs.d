(setq sudo-edit-packages '(sudo-edit
                           dired-toggle-sudo))

(defun sudo-edit/init ()
  (use-package sudo-edit
    :leader ("tfs" sudo-edit-current-file
             "ofs" sudo-edit)))

(defun sudo-edit/init-dired ()
  (use-package dired-toggle-sudo
    :leader ("ts" dired-toggle-sudo))

  (loaded dired
    (m|unbind-key "t" dired-mode-map :if #'commandp)
    (bind-keys :map dired-mode-map
      ("tt" . dired-toggle-marks)
      ("ts" . dired-toggle-sudo))))
