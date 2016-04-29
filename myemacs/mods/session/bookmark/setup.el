(setq bookmark-packages '(bookmark+))

(defun bookmark/init ()
  (loaded bookmark
    (setq bookmark-default-file (m|cache-dir "bookmarks")))

  (use-package bookmark+
    :leader ("bml" bookmark-bmenu-list
             "bmm" bmkp-bookmark-set-confirm-overwrite
             "bmj" bookmark-jump)
    :config
    (setq bmkp-bmenu-state-file (m|cache-dir "bmkp-states.el")
          bmkp-bmenu-commands-file (m|cache-dir "bmkp-commands.el"))))
