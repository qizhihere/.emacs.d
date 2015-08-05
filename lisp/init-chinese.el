(lqz/require '(chinese-pyim pos-tip))

;; company auto complete
(require 'chinese-pyim-company)

(defun pyim-helm-buffer-active-p ()
  (string-prefix-p "helm" (buffer-name (window-buffer (active-minibuffer-window)))))

(setq pyim-company-predict-words-number 10
	  default-input-method "chinese-pyim"
	  pyim-use-tooltip t
	  pyim-dicts-manager-scel2pyim-command (lqz/init-dir "utils/bin/scel2pyim"))


(provide 'init-chinese)
