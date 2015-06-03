(defun lqz/global-set-key (keymap &optional cmd)
  (setf keymap (if (not (listp keymap)) (list keymap cmd) keymap))
    (do ((n 0 (+ n 2)))
	((> n (- (length keymap) 1)) t)
      (global-set-key (kbd (nth n keymap)) (nth (+ n 1) keymap))))

(setq lqz/keymap
      '("C-c m l" helm-all-mark-rings))

(lqz/global-set-key lqz/keymap)



(provide 'my-keymap)
