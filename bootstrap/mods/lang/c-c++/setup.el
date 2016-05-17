(setq c-c++-packages '(irony
                       irony-eldoc
                       company-irony
                       company-irony-c-headers
                       flycheck-irony))

(defun c-c++/init ()
  (use-package cc-mode
    :preface
    (defun m|cc-mode-setup-indent ()
      (setq c-default-style "linux"
            c-basic-offset 2))
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

(defun c-c++/init-irony ()
  (use-package irony
    :defer t
    :diminish irony-mode
    :init
    (add-hooks '(c++-mode-hook c-mode-hook objc-mode-hook) #'irony-mode)

    :config
    (m|load-conf "setup-irony" c-c++)))

(defun c-c++/post-init-flycheck ()
  (defun m|flycheck-clang-enable-c++11 (&rest args)
    (setq flycheck-clang-language-standard "c++11"))
  (add-hook 'c++-mode-hook #'m|flycheck-clang-enable-c++11))
