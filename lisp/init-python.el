(lqz/require 'company-jedi)

(defun lqz/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'lqz/python-mode-hook)


(provide 'init-python)
