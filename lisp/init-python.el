(my/install 'company-jedi)

(defun my/python-mode-hook ()
  (after-load "company"
			  (add-to-list 'company-backends 'company-jedi)))

(add-hook 'python-mode-hook 'my/python-mode-hook)



(provide 'init-python)
