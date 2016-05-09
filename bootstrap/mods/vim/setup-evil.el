;; keep point after `evil-indent'
(advice-add 'evil-indent :around #'m|keep-point-advice)

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
