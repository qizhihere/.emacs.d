(setq buffer-packages '(ibuffer-vc))

(defun buffer/init ()
  (bind-key "C-x B" #'pop-to-buffer)
  (use-package ibuffer
    :bind (("C-x C-b" . ibuffer)
           :map ibuffer-mode-map
           ("U" . ibuffer-unmark-all)
           ("R" . ibuffer-do-replace-regexp)
           ("r" . ibuffer-do-rename-uniquely))))

(defun buffer/init-ibuffer-vc ()
  (use-package ibuffer-vc
    :init
    (add-hook 'ibuffer-hook #'ibuffer-vc-set-filter-groups-by-vc-root)))
