(lqz/require '(company company-statistics company-web))

(add-to-list 'company-backends 'company-web-html)

(add-hook 'after-init-hook 'company-statistics-mode)
(add-hook 'after-init-hook 'global-company-mode)



(provide 'init-company)
