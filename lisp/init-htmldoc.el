;; htmldoc package
(lqz/require 'thingatpt)

(defun edoc-right (url)
  "split new right window and open documentation with eww."
  (let ((eww-win (split-window-right -60)))
    (with-selected-window eww-win
      (line-number-mode -1)
      (eww url)
      (scroll-up 14))))

(defun eww-has-open (url)
  (let ((eww-win (get-buffer-window "*eww*")))
    (if (not eww-win)
	nil
      (with-selected-window eww-win
	(string= eww-current-url url)))))


(defun eww-open-doc (eww-func path)
  "open documentation using self-defined function and path handler."
  (let ((path (expand-file-name path)))
    (if (not (file-exists-p path))
	(message "File not exists :-o [%s]" path)
      (let ((url (concat "file://" path)))
	(if (not (eww-has-open url))
	    (funcall eww-func url))))))


(defun php-doc-path-handler (base-path keyword)
  (concat base-path "/function." (replace-regexp-in-string "_" "-" keyword) ".html"))

(setq php-doc-path (lqz/init-dir "manuals/php_manual_cn_html"))

(defun lookup-php-doc ()
  (interactive)
  (let ((word (lqz/current-word)))
    (if word
	(eww-open-doc
	 #'edoc-right
	 (php-doc-path-handler php-doc-path word))
      (message "No word under cursor :("))))


(defun php-doc-keymap ()
  "bind php doc related keys."
  (define-key php-mode-map (kbd "C-c dg") 'lookup-php-doc))


(add-hook 'php-mode-hook 'php-doc-keymap)



(provide 'init-htmldoc)
