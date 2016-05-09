(setq css-packages '(css-eldoc
                     sass-mode))

(defun css/init ()
  (use-package css-mode
    :defer t
    :config
    (setq css-indent-offset 2)))

(defun css/init-sass ()
  (use-package sass-mode :defer t))

(defun css/init-eldoc ()
  (use-package css-eldoc
    :init
    (add-hook 'css-mode-hook #'turn-on-css-eldoc)
    :commands turn-on-css-eldoc))
