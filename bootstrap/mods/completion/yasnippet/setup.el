(setq yasnippet-packages '(yasnippet))

(defun yasnippet/init ()
  (use-package yasnippet
    :init
    (add-hook 'prog-mode-hook #'yas-minor-mode)
    :diminish yas-minor-mode
    :bind (:map yas-minor-mode-map
           ("M-j" . yas-expand))
    :config
    (setq yas-snippet-dirs '("~/.emacs.d/snippets")
          yas-verbosity 4)
    (add-hook 'snippet-mode (lambda () (setq-local m|whitespace-cleanup-style 'trailing)))

    (loaded company
      (defun m|indent-and-complete ()
        "Indent with `indent-for-tab-command', or show yasnippet candidates."
        (interactive)
        (let ((pos (point)))
          (indent-for-tab-command)
          (when (eq pos (point))
            (silently (company-complete-common))
            (unless company-candidates
              (m|company-yasnippet)))))

      (defun m|company-yasnippet ()
        (interactive)
        (company-abort)
        (let ((prefix (company-yasnippet 'prefix)))
          (when prefix
            (let ((candidates (company-yasnippet 'candidates prefix)))
              (if (and
                   (= (length candidates) 1)
                   (string= prefix (car candidates)))
                  (yas-expand)
                (company-begin-backend 'company-yasnippet))))))

      (bind-keys :map yas-minor-mode-map
        ("TAB" . m|indent-and-complete)
        ("<tab>" . m|indent-and-complete)
        ("M-j" . m|company-yasnippet))

      ;; abort company before yasnippet expansion
      (defun m|yas-abort-company (&rest args)
        (when (fboundp 'company-abort)
          (company-abort)))
      (advice-add 'yas-expand :before #'m|yas-abort-company))

    (silently (yas-reload-all))))
