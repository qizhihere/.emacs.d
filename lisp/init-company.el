(lqz/require '(company company-statistics company-web))


(add-to-list 'company-backends 'company-web-html)
(add-to-list 'company-backends 'company-web-jade)
(add-to-list 'company-backends 'company-web-slim)

(setq company-statistics-file (lqz/init-dir "tmp/company-statistics-cache.el"))

(add-hook 'after-init-hook 'company-statistics-mode)
(add-hook 'after-init-hook 'global-company-mode)



(provide 'init-company)
