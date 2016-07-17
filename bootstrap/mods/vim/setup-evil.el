;; keep point after `evil-indent'
(advice-add 'evil-indent :around #'m|keep-point-advice)

;; unbind some unnecessary keys
(loaded evil-maps
  (unbind-key "M-." evil-normal-state-map))

;; setup emacs style keys
(let ((keys '(("C-a" . beginning-of-line)
              ("C-e" . end-of-line)
              ("C-p" . previous-line)
              ("C-n" . next-line)
              ("C-k" . kill-line)
              ("C-y" . yank)
              ("C-w" . kill-region)
              ("M-a" . backward-sentence)
              ("M-e" . forward-sentence)
              ("C-d" . delete-char)
              ("M-d" . kill-word)
              ("M-DEL" . backward-kill-word))))
  (eval
   `(bind-keys :map evil-normal-state-map   ,@keys
               :map evil-insert-state-map   ,@keys
               :map evil-visual-state-map   ,@keys
               :map evil-replace-state-map  ,@keys
               :map evil-operator-state-map ,@keys)))

(defun m|evil-ex-substitute-fix (orig-func &rest args)
  (let ((evil-search-module 'isearch))
    (apply orig-func args)))
(advice-add 'evil-ex-substitute :around #'m|evil-ex-substitute-fix)
