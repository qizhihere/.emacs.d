(require 'package)
(setq url-configuration-directory (my/init-dir "tmp/url"))

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")))

(setq package-check-signature (when (executable-find "gpg") 'allow-unsigned)
      package-enable-at-startup nil)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; use el-get to install pacakge from everywhere!
(add-to-list 'load-path (my/init-dir "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (package-install 'el-get)
  (require 'el-get))
(add-to-list 'el-get-recipe-path (my/init-dir "el-get-user/recipes"))
(el-get 'sync 'el-get)



(provide 'init-elpa)
