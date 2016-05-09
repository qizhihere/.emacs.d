(defvar startup-idle-hook '() "Hooks run at idle time after Emacs startup.")
(defvar startup-idle-time 1 "Seconds of idle time before run `startup-idle-hook'.")
(defvar startup-idle-timer nil)

(defun setup-startup-hook-timer ()
  (defun run-startup-idle-hooks ()
    (run-hooks 'startup-idle-hook))
  (setq startup-idle-timer
        (run-with-idle-timer
         1 nil #'run-startup-idle-hooks)))

(add-hook 'emacs-startup-hook #'setup-startup-hook-timer)

(defun m|add-startup-hook (hook &optional append)
  (let ((hooks (if (and (not (functionp hook))
                        (listp hook))
                   hook (list hook))))
    (dolist (x hooks)
      (add-hook 'startup-idle-hook x append))))



(provide 'core-startup-hook)
