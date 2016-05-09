(setq window-packages '(popwin
                        window-numbering))

(defun window/init ()
  (use-package winner
    :init
    (m|add-startup-hook #'winner-mode)
    :leader ("ww" window-configuration-to-register))

  (use-package window-utils
    :ensure nil
    :load-path (lambda () (__dir__))
    :leader ("twd" toggle-window-dedicated-p)
    :bind (("C-M-v" . other-window-move-down)
           ("C-M-b" . other-window-move-up))))

(defun window/init-popwin ()
  (use-package popwin
    :disabled t
    :init
    (m|add-startup-hook #'popwin-mode)
    :commands popwin-mode))

(defun window/init-window-numbering ()
  (defvar window-numbering-inhibit-mode-line t
    "If set to t, don't modify `mode-line-format' when
    `window-numbering-mode' enabled.")
  (use-package window-numbering
    :defer t
    :init
    (m|add-startup-hook #'window-numbering-mode)
    :config
    (defun m|window-numbering--inhibit-mode-line (orig-func &rest args)
      (when (not (bound-and-true-p window-numbering-inhibit-mode-line))
        (apply orig-func args)))
    (advice-add 'window-numbering-install-mode-line
                :around #'m|window-numbering--inhibit-mode-line)))
