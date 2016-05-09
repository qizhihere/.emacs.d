(setq dired-packages '(async
                       dired+
                       dired-efap
                       diff-hl
                       dired-filter))

(defun dired/init ()
  (loaded dired
    (m|load-conf "dired-ext" dired)
    (setq dired-dwim-target t)

    ;; (dedicative dired-find-file-other-window)
    )

  (use-package dired-ext
    :ensure nil
    :load-path (lambda () (__dir__))
    :bind (("C-x C-d" . switch-to-dired-buffer))
    :config
    (loaded ivy
      (ivy-set-actions
       'switch-to-dired-buffer
       '(("k" kill-buffer "kill"))))))

(defun dired/init-keys ()
  (loaded dired
    (m|unbind-key '("c" "M" "O" "C-M-b")
                  dired-mode-map :if #'commandp)
    (bind-keys :map dired-mode-map
      ("M" . dired-toggle-marks)
      ("cd" . find-alternate-file)
      ("cc" . dired-do-compress-to)
      ("cm" . dired-do-chmod)
      ("co" . dired-do-chown))))
