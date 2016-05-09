(setq project-packages '(projectile
                         project-explorer))

(defun project/init ()
  (use-package projectile
    :init
    (m|add-startup-hook #'projectile-global-mode)
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

(defun project/init-dired-keys ()
  (loaded dired
    (m|unbind-key "f" dired-mode-map :if #'commandp)
    (bind-keys :map dired-mode-map
      ("ff" . projectile-find-file)
      ("fd" . projectile-find-dir))))

(defun project/init-project-explorer ()
  (use-package project-explorer
    :leader ("pe" project-explorer-open)
    :config
    (setq pe/cache-directory (m|cache-dir "project-explorer"))))
