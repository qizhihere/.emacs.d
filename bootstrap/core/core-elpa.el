(require 'package)

(setq package-check-signature (when (executable-find "gpg") 'allow-unsigned)
      package-enable-at-startup nil)

;; maybe use local elpa repo
(require 'core-elpa-mirror)
(if m|use-elpa-mirror
    (progn
      (setq package-archives nil)
      (enable-elpa-mirror t))
  (dolist (x '(("melpa" . "http://melpa.org/packages/")
               ("org" . "http://orgmode.org/elpa/")))
    (add-to-list 'package-archives x))
  (when m|elpa-mirror-auto-mirroring
    (turn-on-elpa-mirror-timer)))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(m|maybe-install-packages '(elpa-mirror))



(provide 'core-elpa)
