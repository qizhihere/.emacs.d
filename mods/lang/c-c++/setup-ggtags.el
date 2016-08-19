(defvar ggtags-default-tags-directory "~/.gtags")

(let* ((penv (or (getenv "GTAGSLIBPATH") ""))
       (dir (expand-file-name ggtags-default-tags-directory))
       (paths (split-string penv ":" t " ")))
  (unless (member dir paths)
    (setenv "GTAGSLIBPATH"
            (mapconcat #'identity (delq "" `(,dir ,@paths)) ":"))))

(defun m|ggtags-setup-system-library (&optional force)
  (let* ((dir "/usr/include/c++")
         (vers (and (file-exists-p dir)
                    (nreverse (directory-files dir t "^[^.]"))))
         (latest (when vers (car vers)))
         (tags-dir (expand-file-name ggtags-default-tags-directory)))
    (when (and latest (or force (not (file-exists-p tags-dir))))
      (or (file-exists-p tags-dir) (mkdir tags-dir t))
      (call-process "ln" nil nil nil
                    "-s" latest (expand-file-name "c++" tags-dir))
      (let ((default-directory tags-dir)
            (old-v (getenv "GTAGSFORCECPP")))
        (setenv "GTAGSFORCECPP" "true")
        (start-process "gtags" nil "gtags")
        (setenv "GTAGSFORCECPP" old-v)))))

(m|ggtags-setup-system-library)
