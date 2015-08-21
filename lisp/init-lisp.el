(my/install '(eldoc eldoc-eval))
(after-load 'eldoc
  (diminish 'eldoc-mode)
  (eldoc-in-minibuffer-mode 1))

;; eval-expression result pretty print
(my/install 'ipretty)
(ipretty-mode 1)
;; (global-set-key (kbd "M-:") 'eldoc-eval-expression)
(defadvice pp-eval-expression (around my/pp-eval-expression-no-msg activate)
  "silent version of initial `pp-eval-expression'."
  (interactive
   (list (read--expression "Eval: ")))
  (setq values (cons (eval expression lexical-binding) values))
  (pp-display-expression (car values) "*Pp Eval Output*"))

(defadvice pp-display-expression (after my/make-read-only (expression out-buffer-name) activate)
  "enable `view-mode' in the output buffer - if any - so it can be closed with `\"q\"."
  (when (get-buffer out-buffer-name)
    (with-current-buffer out-buffer-name
      (view-mode 1)
      (and (fboundp 'evil-change-state)
           (evil-change-state 'emacs)))))

(my/install 'elisp-slime-nav)
(after-load 'elisp-slime-nav (diminish 'elisp-slime-nav-mode))
(with-installed 'evil
  (after-load 'evil
    (define-key evil-normal-state-map (kbd "M-.") 'elisp-slime-nav-find-elisp-thing-at-point)))

(my/install 'hl-defined)
(with-installed 'hl-defined
  (custom-set-faces
   '(hdefd-functions ((t (:inherit font-lock-function-name-face))))
   '(hdefd-variables ((t (:inherit font-lock-variable-name-face))))))

(defun my/emacs-lisp-setup-hook ()
  (when (require 'hl-defined nil t)
    (hdefd-highlight-mode 1))
  (elisp-slime-nav-mode 1)
  (eldoc-mode 1))
(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'my/emacs-lisp-setup-hook))

(add-hook 'lisp-interaction-mode-hook
          (lambda () (setq mode-name "Lisp")))



(provide 'init-lisp)
