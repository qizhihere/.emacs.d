(setq c-c++-packages '(irony
                       irony-eldoc
                       clang-format
                       company-irony
                       company-irony-c-headers
                       flycheck-irony
                       ggtags))

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


(defun c-c++/init-clang-format ()
  (use-package clang-format
    :defer t
    :preface
    (defun m|setup-clang-format ()
      (setq indent-region-function 'clang-format-region))
    :init
    (add-hook 'c++-mode-hook #'m|setup-clang-format)))

(defun c-c++/init-utils ()
  (use-package c-c++-utils
    :ensure nil
    :load-path (lambda () (__dir__))
    :commands (compile-and-run-current-file
               compile-current-file
               run-current-compiled)
    :config
    (push '(c++-mode . ("g++" "-g" "-std=c++11")) compile-run-compiler-alist)))

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

(defun c-c++/post-init-smartparens ()
  (defun m|c-mode-newline-and-indent-in-braces (&rest args)
    (interactive)
    (save-excursion
      (newline)
      (indent-for-tab-command))
    (indent-for-tab-command))
  (sp-local-pair '(c-mode c++-mode) "{" nil
                 :post-handlers '((m|c-mode-newline-and-indent-in-braces "RET"))))

(defun c-c++/init-ggtags ()
  (use-package ggtags
    :diminish ggtags-mode
    :bind (:map ggtags-mode-map
           ("M-." . ggtags-find-tag-dwim))
    :init
    (add-hook 'c++-mode-hook #'ggtags-mode t)
    (add-hook 'c-mode-hook #'ggtags-mode t)

    :config
    (m|load-conf "setup-ggtags" c-c++)

    (loaded evil (evil-make-overriding-map ggtags-mode-map 'normal))))
