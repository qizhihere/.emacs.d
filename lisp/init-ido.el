(after-init
  ;; remap helm keymaps
  (with-installed 'helm
    (after-load 'helm
      (global-set-key [remap helm-find-files] 'ido-find-file)))

  (require 'ido)
  (ido-mode t)
  (ido-everywhere t)
  (setq ido-enable-flex-matching t)
  (setq ido-use-filename-at-point nil)
  (setq ido-auto-merge-work-directories-length -1)
  (setq ido-use-virtual-buffers t)

  (when (my/install 'ido-ubiquitous)
    (ido-ubiquitous-mode t))

  ;; Allow the same buffer to be open in different frames
  (setq ido-default-buffer-method 'selected-window)

  ;; http://www.reddit.com/r/emacs/comments/21a4p9/use_recentf_and_ido_together/cgbprem
  (add-hook 'ido-setup-hook
            (lambda () (define-key ido-completion-map [up] 'previous-history-element)
              (define-key ido-completion-map (kbd "C-l") 'ido-delete-backward-word-updir))))

(my/install '(idomenu flx-ido))
(after-load 'ido
  (flx-ido-mode 1)
  (setq gc-cons-threshold 10000000)
  (setq ido-enable-flex-matching t)
  (setq flx-ido-use-faces nil))



(provide 'init-ido)
