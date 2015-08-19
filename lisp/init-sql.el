(when (my/install 'sql-indent)
  (after-load 'sql
	(require 'sql-indent)
	(define-key sql-mode-map (kbd "C-c q") 'kill-buffer)))

(my/install 'edbi)

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
  (local-set-key (kbd "M-r") 'helm-comint-history))

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
