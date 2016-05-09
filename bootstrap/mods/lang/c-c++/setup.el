(setq c-c++-packages '(irony))

(defun c-c++/init ()
  (loaded hideif (diminish 'hide-ifdef-mode))
  (add-hooks '(c-mode-hook c++-mode-hook) #'c-c++/setup))

(defun c-c++/setup ()
  (setq c-default-style "linux"
        c-basic-offset 4))

(defun c-c++/post-init-flycheck ()
  (add-hook 'c++-mode-hook
            (lambda () (setq flycheck-clang-language-standard "c++11"))))

(defun c-c++/init-irony ()
  (use-package irony
    :diminish irony-mode
    :init
    (add-hooks '(c++-mode-hook c-mode-hook objc-mode-hook) #'irony-mode)

    ;; replace the `completion-at-point' and `complete-symbol' bindings in
    ;; irony-mode's buffers by irony-mode's function
    (defun m|irony-mode-hook ()
      (define-key irony-mode-map [remap completion-at-point]
        'irony-completion-at-point-async)
      (define-key irony-mode-map [remap complete-symbol]
        'irony-completion-at-point-async))
    (add-hook 'irony-mode-hook 'm|irony-mode-hook)
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)))
