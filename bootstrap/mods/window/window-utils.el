(defvar window-mwheel-scroll-modes '(pdf-view-mode doc-view-mode)
  "The modes where window scrolling prefers mouse wheel way.")
(defvar other-window-move-up-lines 2
  "Default number of lines to move by `other-window-move-up'.")
(defvar other-window-move-down-lines 2
  "Default number of lines to move by `other-window-move-down'.")
(defun other-window-move-down(&optional arg)
  "Other window move-down ARG lines."
  (interactive "p")
  (let* ((win (other-window-for-scrolling))
         (mode (with-selected-window win major-mode))
         (arg (if (eq arg 1) other-window-move-down-lines arg)))
    (if (member mode window-mwheel-scroll-modes)
        (with-selected-window win
          (funcall mwheel-scroll-up-function arg))
      (scroll-other-window arg))))

(defun other-window-move-up(&optional arg)
  "Other window move-up ARG lines."
  (interactive "p")
  (let* ((win0 (selected-window))
         (win (other-window-for-scrolling))
         (mode (with-selected-window win major-mode))
         (arg (if (eq arg 1) other-window-move-up-lines arg)))
    (if (member mode window-mwheel-scroll-modes)
        (progn
          (with-selected-window win
            (funcall mwheel-scroll-down-function arg))
          ;; To fix: After calling `mwheel-scroll-down-function', the
          ;; other window position won't change immediately until a
          ;; new window is created or we switch to the adjusted
          ;; window. Thus we simply switch to the window and then
          ;; swtich back.
          (select-window win)
          (select-window win0))
      (scroll-other-window-down arg))))

(defun toggle-window-dedicated-p (&optional window)
  (interactive)
  (let ((win (or window (selected-window))))
    (unless (boundp 'toggle-window-dedicated-p-message)
      (defvar toggle-window-dedicated-p-message t))
    (when (windowp win)
      (if (window-dedicated-p win)
          (progn
            (when toggle-window-dedicated-p-message
              (message "Window dedicated OFF"))
            (set-window-dedicated-p win nil))
        (when toggle-window-dedicated-p-message
          (message "Window dedicated ON"))
        (set-window-dedicated-p win t)))))



(provide 'window-utils)
