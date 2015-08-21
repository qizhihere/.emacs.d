(my/install '(eldoc eldoc-eval ipretty elisp-slime-nav))

;; eval-expression result pretty print
(ipretty-mode 1)
(global-set-key (kbd "M-:") 'pp-eval-expression)
(defadvice pp-display-expression (after my/make-read-only (expression out-buffer-name) activate)
  "enable `view-mode' in the output buffer - if any - so it can be closed with `\"q\"."
  (when (get-buffer out-buffer-name)
    (with-current-buffer out-buffer-name
      (view-mode 1)
      (and (fboundp 'evil-change-state)
           (evil-change-state 'emacs)))))

(with-installed 'evil
  (after-load 'evil
    (define-key evil-normal-state-map (kbd "M-.") 'elisp-slime-nav-find-elisp-thing-at-point)))

(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'turn-on-elisp-slime-nav-mode)
  (add-hook hook 'eldoc-mode))

(custom-set-faces
 '(hdefd-functions ((t (:inherit font-lock-function-name-face))))
 '(hdefd-variables ((t (:inherit font-lock-variable-name-face)))))
(add-hook 'emacs-lisp-mode-hook (lambda () (require 'hl-defined)
                                  (hdefd-highlight-mode 1)))

(after-load 'elisp-slime-nav (diminish 'elisp-slime-nav-mode))
(after-load 'eldoc (diminish 'eldoc-mode))
(add-hook 'lisp-interaction-mode-hook
          (lambda () (setq mode-name "Lisp")))



(provide 'init-lisp)
