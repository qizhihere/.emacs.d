(setq sql-connection-alist
	  '((localhost (sql-product 'mysql)
				   (sql-port 3306)
				   (sql-server "127.0.0.1"))
		(vps (sql-product 'mysql)
			 (sql-port 3306)
			 (sql-server "localhost")
			 (sql-user "root")
			 (sql-password "password")
			 (sql-database "db2"))
		(project (sql-product 'mysql)
				 (sql-server "127.0.0.1")
				 (sql-port 3306)
				 (sql-user "compass_master")
				 (sql-password "s7yhs%G&*J")
				 (sql-database "compass_master"))))


(defun my/sql-local-conn ()
  (interactive)
  (my/sql-connect 'mysql 'localhost))

(defun my/sql-project-conn ()
  (interactive)
  (my/sql-connect 'mysql 'project))

(defun my/sql-vps-conn ()
  (interactive)
  (my/sql-connect 'mysql 'vps))

(defun my/sql-connect (product connection)
  (setq sql-product product)
  (sql-connect connection))

(setq sql-mysql-login-params
	  '((user :default "root")
	(database :default "mysql")
	(server :default "localhost")
	(port :default 3306)))


;; ******************************
;; use helm to show history
;; ******************************
(setq helm-source-comint-history
  '((name . "Comint History")
	(candidates . (lambda ()
			(let ((ring (buffer-local-value 'comint-input-ring helm-current-buffer)))
			  (if (ring-p ring)
			  (ring-elements ring)))))
	(candidate-number-limit . 4096)
	(multiline)
	(action . (("Insert" . (lambda (candidate)
				 (comint-goto-process-mark)
				 (comint-delete-input)
				 (insert candidate)))
		   ("Execute" . (lambda (candidate)
				  (comint-goto-process-mark)
				  (comint-delete-input)
				  (insert candidate)
				  (comint-send-input)))))))

;; helm settings
(defun helm-comint-history ()
  (interactive)
  (helm :sources helm-source-comint-history
	:input (thing-at-point 'symbol)
	:buffer "*helm comint history*"))

(setq comint-input-ring-size 4096)

(defun comint-history-common-setup ()
  (setq comint-input-ignoredups t)

  (local-set-key (kbd "M-p") 'comint-previous-matching-input-from-input)
  (local-set-key (kbd "M-n") 'comint-next-matching-input-from-input)
  (local-set-key (kbd "M-r") 'helm-comint-history)
)

;; inferior-python-mode-hook
(add-hook 'inferior-python-mode-hook 'comint-history-common-setup)

;; inf-ruby-mode-hook
(add-hook 'inf-ruby-mode-hook 'comint-history-common-setup)

(defadvice sql-interactive-mode (around ad-sql-interactive-mode activate)
  (let (comint-input-ring-separator)
	ad-do-it))


;; add hooks
(add-hook 'sql-interactive-mode-hook
	  (lambda ()
		(toggle-truncate-lines t)
		(comint-history-common-setup)))



(provide 'init-sql)
