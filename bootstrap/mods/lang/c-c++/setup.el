(setq c-c++-packages '(irony))

(defun c-c++/init ()
  (use-package cc-mode
    :preface
    (defun m|cc-mode-setup-indent ()
      (setq c-default-style "Linux"
            c-basic-offset 4))
    :init
    (add-hooks '(c-mode-hook c++-mode-hook) #'m|cc-mode-setup-indent)

    :config
    (let ((keys '(("<f5>" . compile)
                  ("C-<f5>" . compile-and-run-current-file)
                  ("S-<f5>" . compile-current-file)
                  ("M-<f5>" . clean-current-compiled))))
      (eval `(bind-keys :map c++-mode-map ,@keys))
      (eval `(bind-keys :map c-mode-map ,@keys)))))

(defun c-c++/init-utils ()
  (use-package c-c++-utils
    :ensure nil
    :load-path (lambda () (__dir__))
    :commands (compile-and-run-current-file
               compile-current-file
               run-current-compiled)))

(defun c-c++/post-init-flycheck ()
  (defun m|flycheck-clang-enable-c++11 (&rest args)
    (setq flycheck-clang-language-standard "c++11"))
  (add-hook 'c++-mode-hook #'m|flycheck-clang-enable-c++11))

(defun c-c++/init-irony ()
  (use-package irony
    :defer t
    :diminish irony-mode
    :init
    (add-hooks '(c++-mode-hook c-mode-hook objc-mode-hook) #'irony-mode)

    :config
    ;; don't enter irony-mode if current major mode is not supported
    (defun m|irony-mode-check-support (orig-func &rest args)
      (when (memq major-mode irony-supported-major-modes)
        (apply orig-func args)))
    (advice-add 'irony-mode :around #'m|irony-mode-check-support)

    ;; replace the `completion-at-point' and `complete-symbol' bindings in
    ;; irony-mode's buffers by irony-mode's function
    (defun m|irony-remap-key ()
      (define-key irony-mode-map [remap completion-at-point]
        'irony-completion-at-point-async)
      (define-key irony-mode-map [remap complete-symbol]
        'irony-completion-at-point-async))
    (add-hook 'irony-mode-hook 'm|irony-remap-key)
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)))
