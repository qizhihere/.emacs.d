(defun m|pp-display-maybe-change-evil-state (exp buf)
  "enable `view-mode' in pp output buffer - if any - so it can be closed with `\"q\"."
  (when (get-buffer buf)
    (with-current-buffer buf
      (view-mode 1)
      (and (fboundp 'evil-change-state)
           (evil-change-state 'emacs)))))
(advice-add 'pp-display-expression :after #'m|pp-display-maybe-change-evil-state)
