(defun xterm/init ()
  (unless window-system
    (xterm-mouse-mode t)
    (m|load-relative "special-keys")))
