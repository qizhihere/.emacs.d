(setq modeline-packages '(spaceline))

(defun modeline/init ()
  (column-number-mode 1)
  (size-indication-mode 1)

  ;; display time in mode line
  (setq display-time-format "%p%H:%M"
        display-time-default-load-average nil)
  (display-time-mode 1))

(defun modeline/init-spaceline ()
  (use-package spaceline
    :defer t
    :config
    (setq spaceline-highlight-face-func #'spaceline-highlight-face-evil-state
          spaceline-face-func #'modeline|spaceline-custom-inactive-face
          spaceline-window-numbers-unicode t
          spaceline-workspace-numbers-unicode t)

    (defun modeline|spaceline-custom-inactive-face (face active)
      (cond
       ((and (eq 'line face) (not active)) 'modeline-inactive)
       (t (let (spaceline-face-func)
            (spaceline--get-face face active))))))

  (defun spaceline/setup ()
    (require 'spaceline-config)
    (spaceline-emacs-theme))
  (m|add-startup-hook #'spaceline/setup))
