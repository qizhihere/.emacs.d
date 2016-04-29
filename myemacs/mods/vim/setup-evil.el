;; enable normal state in these modes
(defvar evil-normal-state-modes '()
  "The modes where evil should initialize to normal state.")
(defun m|evil--maybe-normal-state-advice (&rest args)
  (when (and (loop for m in evil-normal-state-modes
                   thereis (derived-mode-p m))
             (loop for m in evil-emacs-state-modes
                   never (derived-mode-p m)))
    (evil-change-state 'normal)))
(advice-add 'evil-initialize :after #'m|evil--maybe-normal-state-advice)

;; add my custom modes of emacs/normal state
(dolist (m (append evil-insert-state-modes
                   (bound-and-true-p m|evil-emacs-state-modes)))
  (add-to-list 'evil-emacs-state-modes m))
(dolist (m (bound-and-true-p m|evil-normal-state-modes))
  (add-to-list 'evil-normal-state-modes m))

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
