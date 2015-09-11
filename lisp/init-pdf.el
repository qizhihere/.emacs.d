;; pdf tools
(my/install 'pdf-tools)
(pdf-tools-install)

(setq my/pdf-view-mode-keypairs
      '(([down-mouse-1] pdf-view-mouse-set-region)
        ([C-down-mouse-1] pdf-view-mouse-extend-region)
        ([M-down-mouse-1] pdf-view-mouse-set-region-rectangle)
        ([triple-mouse-6] image-backward-hscroll)
        ([triple-mouse-7] image-forward-hscroll)))

(dolist (pair my/pdf-view-mode-keypairs)
  (define-key pdf-view-mode-map (car pair) (cadr pair)))


(provide 'init-pdf)
