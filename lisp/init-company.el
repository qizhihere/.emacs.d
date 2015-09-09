(my/install '(company company-statistics))

(setq company-statistics-file
      (my/init-dir "tmp/company-statistics-cache.el"))

(setq-default company-idle-delay 0.1
              company-show-numbers t)

(after-load "company"
  (diminish 'company-mode)
  (company-statistics-mode))

(after-init (global-company-mode))



(provide 'init-company)
