(require 'dired)
(loaded dired-async (dired-async-mode 1))

(use-package dired-filter
  :init
  (define-key dired-mode-map (kbd "F") dired-filter-map)
  (define-key dired-mode-map (kbd "/") dired-filter-map)
  :bind (:map dired-mode-map
         ("/P" . dired-filter-pop-all))
  :config
  (setq dired-filter-verbose nil))

(use-package dired+
  :commands dired-hide-details-mode
  :init
  (m|be-quiet diredp-make-find-file-keys-not-reuse-dirs
              diredp-make-find-file-keys-reuse-dirs)
  (toggle-diredp-find-file-reuse-dir 1)
  :bind (:map dired-mode-map
         (")" . dired-hide-details-mode)))

(use-package dired-efap
  :bind (:map dired-mode-map
         ("r" . dired-efap)))

(use-package diff-hl
  :init
  (add-hook 'dired-mode-hook #'diff-hl-dired-mode))

;; List directories first
(defun m|dired-sort-prefer-directory ()
  "Dired sort hook to list directories first."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2) ;; beyond dir. header
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max))))
  (and (featurep 'xemacs)
       (fboundp 'dired-insert-set-properties)
       (dired-insert-set-properties (point-min) (point-max)))
  (set-buffer-modified-p nil))
(add-hook 'dired-after-readin-hook #'m|dired-sort-prefer-directory)

(defun switch-to-dired-buffer ()
  (interactive)
  (let ((bufs (mapcar (lambda (it) (buffer-name it))
                      (remove-if-not
                       (lambda (bf)
                         (with-current-buffer bf
                           (eql major-mode 'dired-mode)))
                       (buffer-list)))))
    (if (> (length bufs) 0)
        (switch-to-buffer
         (completing-read "Switch to Dired buffer: " bufs))
      (message "There are no dired buffers."))))

