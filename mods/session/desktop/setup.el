(setq desktop-packages '(session))

(defun desktop/init ()
  (use-package desktop
    :init
    (unless (member "--no-desktop" command-line-args)
      (desktop-save-mode 1))
    :config
    (let ((desktop-dir (m|cache-dir "desktop")))
      (unless (file-directory-p desktop-dir)
        (mkdir desktop-dir))

      (setq desktop-path `(,desktop-dir)
            desktop-dirname desktop-dir
            desktop-auto-save-timeout 5
            desktop-restore-eager 5
            session-save-file (concat desktop-dir "/last-session")))

    (use-package session
      :init
      (add-hook 'desktop-after-read-hook #'session-initialize)
      (add-hook 'desktop-save-hook #'session-save-session)
      :commands session-save-session
      :config
      (setq session-name-disable-regexp "\\(?:\\.git/[A-Z_]+\\'\\|\\`/tmp/\\)")
      (m|be-quiet session-initialize session-save-session)))

  (m|evil-leader ";dl" 'desktop-lazy-complete))
