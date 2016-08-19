(defun xterm/init ()
  (unless window-system
    (xterm-mouse-mode t)
    (m|load-conf "special-keys" xterm)))
