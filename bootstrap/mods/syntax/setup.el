(setq syntax-packages '(flycheck))

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
          flycheck-temp-prefix ".flycheck")))

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
        (setq ispell-alternate-dictionary dict)))))
