(setq company-packages '(company
                         company-statistics))

(defun company/init ()
  (use-package company
    :defer t
    :init
    (m|add-startup-hook #'global-company-mode)
    :diminish company-mode
    :config
    (setq company-idle-delay 0.1
          company-show-numbers t
          company-minimum-prefix-length 2
          company-dabbrev-downcase nil
          company-tooltip-align-annotations t)

    (m|load-conf "company-utils" company)
    (make-variable-buffer-local 'company-backends)

    (m|be-quiet company-ispell))

  (use-package company-utils
    :load-path (lambda () (__dir__))
    :commands (company/add-local-backend
               company/add-general-backend
               company/remove-general-backend)))

(defun company/init-company-statistics ()
  (use-package company-statistics
    :defer t
    :init
    (unless (member "--no-desktop" command-line-args)
      (loaded company (company-statistics-mode 1)))
    :config
    (setq company-statistics-file
          (m|cache-dir "company-statistics-cache.el"))
    (m|be-quiet company-statistics-mode
                company-statistics--maybe-save)))
