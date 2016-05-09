;; keep this comment to prevent Emacs adding (package-initialize) here
;; (package-initialize)

(setq gc-cons-threshold 100000000)
(setq ad-redefinition-action 'accept)

(setq max-specpdl-size 3000)
(load (locate-user-emacs-file "elpa/benchmark-init-20150905.238/benchmark-init-autoloads.el") nil t)
(benchmark-init/activate)

(defconst m|home (expand-file-name user-emacs-directory)
  "The absolute emacs dotfiles path.")
(defconst m|conf-dir "bootstrap"
  "The root directory name of my emacs configs.")
(defconst m|conf (expand-file-name m|conf-dir m|home)
  "The absolute path of my emacs configs.")

(defconst m|emacs-min-version "24.3"
  "Required minimal Emacs version.")

(if (not (version< emacs-version m|emacs-min-version))
    (let ((boot-file (format "%s/boot.el" m|conf)))
      (if (file-exists-p boot-file)
          (load boot-file nil t)
        (message "No boot file found. Emacs boot failed.")))
  (message (concat "The minimal Emacs version required is %s. "
                   "Please upgrade Emacs.") m|emacs-min-version))
