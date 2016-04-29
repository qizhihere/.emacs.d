(setq project-packages '(projectile))

(defun projectile/init ()
  (use-package projectile
    :init
    (m|add-idle-hook #'projectile-global-mode)
    :diminish projectile-mode
    :leader ("pb" projectile-switch-to-buffer
             "pd" projectile-dired
             "pl" projectile-switch-project
             "pf" projectile-find-file
             "ff" projectile-find-file
             "fd" projectile-find-dir
             "pd" projectile-find-dir
             "po" projectile-multi-occur
             "pk" projectile-kill-buffers)
    :config
    (setq projectile-require-project-root nil
          projectile-find-dir-includes-top-level t
          projectile-enable-caching t
          projectile-cache-file (m|cache-dir "projectile.cache")
          projectile-known-projects-file (m|cache-dir "projectile-bookmarks.el"))))
