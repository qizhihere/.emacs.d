(setq syntax-packages '(flycheck
                        flyspell-correct-popup
                        popup))

(defun syntax/init ()
  (use-package ispell
    :defer t
    :diminish ispell-minor-mode))

(defun syntax/init-flycheck ()
  (use-package flycheck
    :init
    (m|add-startup-hook #'global-flycheck-mode)
    :diminish flycheck-mode
    :leader ("tmf" flycheck-mode
             "er" flycheck-list-errors)
    :config
    (setq flycheck-idle-change-delay 2
          flycheck-temp-prefix ".flycheck")

    ;; custom fringes
    (when (fboundp 'define-fringe-bitmap)
      (define-fringe-bitmap 'my-flycheck-fringe-indicator
        (vector #b00000000
                #b00000000
                #b00000000
                #b00000000
                #b00000000
                #b00000000
                #b00000000
                #b00011100
                #b00111110
                #b00111110
                #b00111110
                #b00011100
                #b00000000
                #b00000000
                #b00000000
                #b00000000
                #b00000000)))

    (flycheck-define-error-level 'error
      :overlay-category 'flycheck-error-overlay
      :fringe-bitmap 'my-flycheck-fringe-indicator
      :fringe-face 'flycheck-fringe-error)

    (flycheck-define-error-level 'warning
      :overlay-category 'flycheck-warning-overlay
      :fringe-bitmap 'my-flycheck-fringe-indicator
      :fringe-face 'flycheck-fringe-warning)

    (flycheck-define-error-level 'info
      :overlay-category 'flycheck-info-overlay
      :fringe-bitmap 'my-flycheck-fringe-indicator
      :fringe-face 'flycheck-fringe-info)))

(defun syntax/init-flyspell ()
  (use-package flyspell
    :init
    (add-hook 'prog-mode-hook #'flyspell-prog-mode)
    :diminish flyspell-mode
    :leader ("tmS" flyspell-prog-mode)
    :config
    (cond
     ((executable-find "aspell")
      (setq ispell-program-name "aspell")
      (setq ispell-extra-args '("--sug-mode=ultra")))
     ((executable-find "ispell")
      (setq ispell-program-name "ispell"))
     (t (setq ispell-program-name nil)))

    ;; maybe change dictionary
    (m|be-quiet ispell-init-process)
    (when (bound-and-true-p ispell-program-name)
      (silently (ispell-change-dictionary "american" t)))

    ;; maybe use a english words dictionary
    (let ((dict (m|home "dicts/en-words.txt")))
      (when (file-exists-p dict)
        (setq ispell-alternate-dictionary dict)))

    (bind-keys :map flyspell-mode-map
      ("C-;" . flyspell-correct-word-generic)))

  (use-package popup
    :commands popup-make-item)
  (use-package flyspell-correct-popup
    :commands flyspell-correct-popup)
  (use-package flyspell-correct
    :defer t
    :config
    (setq flyspell-correct-interface 'flyspell-correct-popup)))
