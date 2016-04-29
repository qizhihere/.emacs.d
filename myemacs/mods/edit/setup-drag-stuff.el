(loaded evil
  (defun m|drag-stuff-fix--evil (orig-func &rest args)
    "Make drag stuff compatible with evil visual state."
    (if (eq evil-state 'visual)
        (progn
          (let ((beg (region-beginning))
                (end (region-end)))
            (evil-change-state 'emacs)
            (goto-char beg)
            (set-mark-command nil)
            (goto-char end)
            (apply orig-func args)
            (evil-change-state 'visual)))
      (apply orig-func args)))
  (advice-add 'drag-stuff--execute :around #'m|drag-stuff--fix-evil))
