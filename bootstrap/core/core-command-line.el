(defun m|handle-command-line-args (args)
  (let ((i 0)
        (len (length args))
        arg rest)
    (while (< i len)
      (setq arg (nth i args))
      (pcase arg
        ("--elpa-mirror"
         (setq m|use-elpa-mirror t))
        ("--elpa-mirror-directory"
         (setq i (1+ i)
               elpa-mirror-directory (nth i args)))
        (_ (push arg rest)))
      (setq i (1+ i)))
    (nreverse rest)))

(setq command-line-args (m|handle-command-line-args command-line-args))



(provide 'core-command-line)
