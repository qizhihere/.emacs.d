(defun recentf/init ()
  (use-package recentf
    :init
    (m|add-startup-hook #'recentf/setup)
    :config
    (setq recentf-max-saved-items 100
          recentf-save-file (m|cache-dir "recentf"))
    (m|be-quiet recentf-cleanup recentf-load-list)))

(defun recentf/setup ()
  (recentf-mode 1)
  ;; don't persist recentf file if Emacs boots with --no-desktop
  (unless desktop-save-mode
    (setq recentf-save-file (make-temp-file ".recentf-"))
    (remove-hook 'kill-emacs-hook #'recentf-save-list)

    (unless (fboundp 'm|clean-tmp-recentf-file)
      (defun m|clean-tmp-recentf-file ()
        (when (string-prefix-p temporary-file-directory recentf-save-file)
          (delete-file recentf-save-file))))
    (add-hook 'kill-emacs-hook #'m|clean-tmp-recentf-file)))
