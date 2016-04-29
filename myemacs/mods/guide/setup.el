(setq guide-packages '(which-key))

(defun guide/init ()
  )

(defun guide/init-which-key ()
  (use-package which-key
    :diminish which-key-mode
    :leader ("tk" which-key-mode)
    :config
    (setq which-key-idle-delay 0.4)))


(defun guide/init-hydra ()
  )
