(defun show-startup-time ()
  "Display startup time of Emacs in echo area."
  (let ((now (float-time)))
    (cond ((and desktop-save-mode
                (bound-and-true-p before-restore-time))
         (message "Emacs loaded in %.2fs, desktop restored in %.2fs."
                  (- now
                     (time-to-seconds before-init-time))
                  (- now
                     (time-to-seconds before-restore-time))))
        (t (message "Emacs loaded in %.2fs."
                  (- now
                     (time-to-seconds before-init-time)))))))

(defun startup-time--setup-desktop ()
  (defvar before-restore-time nil
    "The time when Emacs start restore desktop.")
  (when (file-exists-p (desktop-full-file-name))
    (setq before-restore-time (current-time))))

(defun startup-time/setup ()
  (advice-add 'desktop-read :before #'startup-time--setup-desktop)
  (add-hook 'emacs-startup-hook #'show-startup-time))
