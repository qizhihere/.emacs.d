(require 'smartparens)

;; disable default quote pair in certain modes
(dolist (mode '(text-mode minibuffer-inactive-mode))
  (sp-local-pair mode "'" "")
  (sp-local-pair mode "`" ""))

;; advice to temporarily disable smartparens
(defvar smartparens-temp-disabled nil)
(defun m|smartparens-temp-disable (&rest args)
  "Temporary disable smartparens."
  (when smartparens-mode
    (smartparens-mode -1)
    (setq-local smartparens-temp-disabled t)))
(defun m|smartparens-maybe-reenable (&rest args)
  "Re-enable smartparens if it has been temporarily disabled."
  (when smartparens-temp-disabled
    (setq-local smartparens-temp-disabled nil)
    (smartparens-mode 1)))

;; disable smartparens during yasnippet expansion
(loaded yasnippet
  (advice-add 'yas-expand-snippet :before #'m|smartparens-temp-disable)
  (advice-add 'yas-expand-snippet :after #'m|smartparens-maybe-reenable))

;; enable smartparens in eval expression minibuffer
(defun m|eval-expression-minibuffer-enable-smartparens ()
  (let (sp-ignore-modes-list)
    (smartparens-mode 1)))
(add-hook 'eval-expression-minibuffer-setup-hook
          #'m|eval-expression-minibuffer-enable-smartparens)

;; some pair wrap/unwrap functions
(defmacro sp-define-pairs (pairs)
  `(progn
     ,@(loop for (key . val) in pairs
             collect
             `(defun ,(read (concat
                             "sp-wrap-with-"
                             (prin1-to-string key)
                             "s"))
                  (&optional arg)
                (interactive "p")
                (sp-wrap-with-pair ,val)))))

(sp-define-pairs ((paren        . "(")
                  (bracket      . "[")
                  (brace        . "{")
                  (single-quote . "'")
                  (double-quote . "\"")
                  (back-quote   . "`")
                  (underscore   . "_")))


;; enhancements in some language
(defun m|c-mode-newline-and-indent-in-braces (&rest args)
  (interactive)
  (save-excursion
    (newline)
    (indent-for-tab-command))
  (indent-for-tab-command))
(sp-local-pair '(c-mode c++-mode go-mode php-mode js2-mode) "{" nil
               :post-handlers '((m|c-mode-newline-and-indent-in-braces "RET")))

(sp-local-pair '(go-mode) "(" nil
               :post-handlers '((m|c-mode-newline-and-indent-in-braces "RET")))
