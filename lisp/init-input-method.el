(lqz/require '(chinese-pyim pos-tip))

;; company auto complete
(require 'chinese-pyim-company)

(defun pyim-helm-buffer-active-p ()
  (string-prefix-p "helm" (buffer-name (window-buffer (active-minibuffer-window)))))

(setq pyim-company-predict-words-number 10
      default-input-method "chinese-pyim"
      pyim-use-tooltip t
      pyim-dicts-manager-scel2pyim-command (lqz/init-dir "utils/bin/scel2pyim"))

(define-key org-mode-map (kbd "M-f") 'pyim-forward-word)
(define-key org-mode-map (kbd "M-b") 'pyim-backward-word)


(provide 'init-input-method)
