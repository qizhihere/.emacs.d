(setq emacs-lisp-packages '(eldoc
                            eldoc-eval
                            hl-defined))

(defun emacs-lisp/init ()
  (defun emacs-lisp/setup-elisp-mode ()
    (hdefd-highlight-mode 1)
    (elisp-slime-nav-mode 1)
    (eldoc-mode 1))
  (add-hook 'emacs-lisp-mode-hook #'emacs-lisp/setup-elisp-mode)
  (add-hook 'ielm-mode-hook #'emacs-lisp/setup-elisp-mode)

  (loaded elisp-mode
    (m|load-relative "redef-lisp-indent" #$)
    (use-package pp
      :ensure nil
      :bind (:map emacs-lisp-mode-map
             ("C-x C-e" . pp-eval-last-sexp)))))

(defun emacs-lisp/post-init-flycheck ()
  (setq-default flycheck-disabled-checkers
                (add-to-list 'flycheck-disabled-checkers 'emacs-lisp-checkdoc)))

(defun emacs-lisp/post-init-smartparens ()
  (loaded elisp-mode
    ;; disable ' pair
    (sp-local-pair 'emacs-lisp-mode "'" "")

    ;; add `' pair for comments
    (defun m|sp-point-in-string-or-comment (&rest args)
      (sp-point-in-string-or-comment))
    (sp-local-pair 'emacs-lisp-mode "`" "'"
                   :when '(m|sp-point-in-string-or-comment))))

(defun emacs-lisp/init-eldoc ()
  (use-package eldoc-eval :commands eldoc-in-minibuffer-mode)
  (use-package eldoc
    :defer t
    :diminish eldoc-mode
    :config
    (eldoc-in-minibuffer-mode 1)))

(defun emacs-lisp/init-hl-defined ()
  (use-package hl-defined
    :commands hdefd-highlight-mode
    :config
    (custom-set-faces
     '(hdefd-functions ((t (:inherit font-lock-function-name-face))))
     '(hdefd-variables ((t (:inherit font-lock-variable-name-face)))))))

(defun emacs-lisp/init-elisp-slime-nav ()
  (use-package elisp-slime-nav
    :diminish elisp-slime-nav-mode
    :bind (:map emacs-lisp-mode-map
           ("M-." . elisp-slime-nav-find-elisp-thing-at-point))
    :evil (:map emacs-lisp-mode-map :defer elisp-mode
           ("M-." . elisp-slime-nav-find-elisp-thing-at-point))))

(defun emacs-lisp/init-pp ()
  (use-package pp
    :defer t
    :config
    (m|load-relative "redef-pp" #$)
    (m|load-relative "setup-pp" #$)))
