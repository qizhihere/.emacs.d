;; use c++11
(defun m|irony-setup-c++11 ()
  (when (eq major-mode 'c++-mode)
    (setq-local irony-additional-clang-options '("-std=c++11"))))
(add-hook 'irony-mode-hook #'m|irony-setup-c++11)

;; don't enter irony-mode if current major mode is not supported
(defun m|irony-check-mode-support (orig-func &rest args)
  (when (memq major-mode irony-supported-major-modes)
    (apply orig-func args)))
(advice-add 'irony-mode :around #'m|irony-check-mode-support)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun m|irony-remap-key ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'm|irony-remap-key)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; company completion
(loaded company
  (defun m|irony-setup-company ()
    (company/add-local-backend '(company-irony-c-headers company-irony)))
  (add-hook 'irony-mode-hook #'m|irony-setup-company))

;; eldoc
(add-hook 'irony-mode-hook #'irony-eldoc)

;; flycheck
(loaded flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
