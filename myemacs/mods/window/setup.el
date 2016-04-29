(setq window-packages '(persp-mode))

(defun window/init ()
  (use-package window-utils
    :ensure nil
    :load-path (lambda () (file-name-directory #$))
    :bind (("C-M-v" . other-window-move-down)
           ("C-M-b" . other-window-move-up))))

(defun window/init-persp-mode ()
  (use-package persp-mode
    :init
    (add-hook 'desktop-save-mode #'persp-mode)
    :leader ("w" persp-key-map)
    :config
    (customize-set-variable 'persp-keymap-prefix "C-c w")))
