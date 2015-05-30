;; set repo
(setq package-archives '(
	("melpa" . "http://melpa.org/packages/")
	("org" . "http://orgmode.org/elpa/")
	("marmalade" . "http://marmalade-repo.org/packages/")
	("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))



(provide 'init-elpa)
