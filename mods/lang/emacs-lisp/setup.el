(setq emacs-lisp-packages '(eldoc
                            eldoc-eval
                            elisp-slime-nav
                            hl-defined))

(defun emacs-lisp/init ()
  (loaded elisp-mode
    (m|load-conf "redef-lisp-indent" emacs-lisp)
    (use-package pp
      :ensure nil
      :bind (:map emacs-lisp-mode-map
             ("C-x C-e" . pp-eval-last-sexp)))))

(defun emacs-lisp/init-repl ()
  (loaded elisp-mode
    (define-repl elisp-repl ()
      "Run Emacs lisp REPL in a buffer."
      (cl-letf (((symbol-function 'pop-to-buffer-same-window) #'pop-to-buffer))
        (ielm)
        (process-make-buffer-dedicated (current-buffer))))
    (defalias 'emacs-lisp-repl 'elisp-repl)
    (defalias 'emacs-lisp-repl-maximized 'elisp-repl-maximized)

    (bind-keys :map emacs-lisp-mode-map
      ("C-c <f12>" . elisp-repl)
      ("C-c C-<f12>" . elisp-repl-maximized))))

(defun emacs-lisp/post-init-flycheck ()
  (setq-default flycheck-disabled-checkers
                (add-to-list 'flycheck-disabled-checkers 'emacs-lisp-checkdoc)))

(defun emacs-lisp/post-init-smartparens ()
  (loaded elisp-mode
    ;; disable ' pair
    (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)

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
    :init
    (add-hooks '(emacs-lisp-mode-hook ielm-mode-hook) #'eldoc-mode)
    :config
    (eldoc-in-minibuffer-mode 1)))

(defun emacs-lisp/init-hl-defined ()
  (use-package hl-defined
    :commands hdefd-highlight-mode
    :init
    (add-hooks '(emacs-lisp-mode-hook ielm-mode-hook) #'hdefd-highlight-mode)
    :config
    (custom-set-faces
     '(hdefd-functions ((t (:inherit font-lock-function-name-face))))
     '(hdefd-variables ((t (:inherit font-lock-variable-name-face)))))))

(defun emacs-lisp/init-elisp-slime-nav ()
  (use-package elisp-slime-nav
    :defer t
    :diminish elisp-slime-nav-mode
    :init
    (add-hooks '(emacs-lisp-mode-hook ielm-mode-hook) #'elisp-slime-nav-mode)))

(defun emacs-lisp/init-pp ()
  (use-package pp
    :defer t
    :config
    (m|load-conf "redef-pp" emacs-lisp)
    (m|load-conf "setup-pp" emacs-lisp)))
