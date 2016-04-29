;; make sure swiper recenter after action finished
(progn
  (defvar swiper-recenter-line t
    "Whether recenter line after swiper finished.")
  (defun m|swiper-recenter(&rest args)
    (when swiper-recenter-line
      (recenter)))
  (advice-add 'swiper--action :after 'm|swiper-recenter))

;; fix dired mode key
(loaded dired
  (define-key dired-mode-map (kbd "M-i") #'swiper))    


