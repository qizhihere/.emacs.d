;; pdf tools
(my/install 'pdf-tools)
(pdf-tools-install)
(define-key pdf-view-mode-map [down-mouse-1] 'pdf-view-mouse-set-region)
(define-key pdf-view-mode-map [C-down-mouse-1] 'pdf-view-mouse-extend-region)
(define-key pdf-view-mode-map [M-down-mouse-1] 'pdf-view-mouse-set-region-rectangle)



(provide 'init-pdf)
