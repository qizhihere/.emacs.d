(setq dired-packages '(async
                       dired-efap
                       diff-hl
                       dired-filter))

(defun dired/init ()
  (loaded dired
    (m|load-relative "dired-ext" #$)
    (setq dired-dwim-target t))

  (use-package dired-ext
    :ensure nil
    :load-path (lambda () (file-name-directory #$))
    :bind (("C-x C-d" . switch-to-dired-buffer))))
