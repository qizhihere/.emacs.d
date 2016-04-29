(setq company-packages '(company
                         company-statistics))

(defun company/init ()
  (use-package company
    :init
    (m|add-idle-hook #'global-company-mode)
    :diminish company-mode
    :config
    (setq company-idle-delay 0.1
          company-show-numbers t
          company-minimum-prefix-length 2
          company-dabbrev-downcase nil)

    (m|be-quiet company-ispell)
    ;; (company/setup-local-backends)
    ))

(defun company/init-company-statistics ()
  (use-package company-statistics
    :defer t
    :config
    (setq company-statistics-file
          (m|cache-dir "company-statistics-cache.el"))))

(defun company/setup-local-backends ()
  (defun m|company--make-backend-local-advice (&rest args)
    (make-local-variable 'company-backends))
  (advice-add 'company-mode-on :before #'m|company--make-backend-local-advice)

  (defun m|company-add-general-backend (backend)
    (loop for x in company-backends
          for i from 0
          for x = (if (listp x) x (list x))
          do
          (unless (memq backend x)
            (if (memq :with x)
                (nconc x `(,backend))
              (nconc x `(:with ,backend)))
            (setf (nth i company-backends) x))
          collect x))

  (defun m|company-remove-general-backend (backend)
    (loop for x in company-backends
          for i from 0
          for x = (if (listp x) x (list x))
          for y = (memq :with x)
          do
          (when (memq backend y)
            (delq backend y)
            (when (= (length y) 1)
              (delq :with x))
            (when (= (length x) 1)
              (setq x (car x)))
            (setf (nth i company-backends) x))
          collect x))

  (defvar company-general-backends '(company-yasnippet)
    "General backends which can be used with any backend.")
  (defun m|company-add-general-backends ()
    (dolist (x company-general-backends)
      (let ((var (intern (format "enable-%s" x))))
        (when (or (eval `(bound-and-true-p ,var))
                  (not (boundp var)))
          (m|company-add-general-backend x)))))
  (add-hook 'company-mode-hook #'m|company-add-general-backends))
