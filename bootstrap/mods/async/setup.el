(setq async-packages '(async))

(defun async/init ()
  (use-package async
    :defer t
    :config
    (setq async-bytecomp-allowed-packages '(all))))
