(require 'package)

(setq package-check-signature (when (executable-find "gpg") 'allow-unsigned)
      package-enable-at-startup nil)

;; maybe use local elpa mirror
(require 'core-elpa-mirror)
(if (bound-and-true-p m|use-elpa-mirror)
    (progn
      (setq package-archives nil)
      (enable-elpa-mirror t))
  (dolist (x '(("melpa" . "http://melpa.org/packages/")
               ("org" . "http://orgmode.org/elpa/")))
    (add-to-list 'package-archives x)))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))



(provide 'core-elpa)
