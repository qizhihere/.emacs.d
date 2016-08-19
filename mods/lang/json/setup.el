(setq json-packages '(json-mode))

(defun json/init ()
  (use-package json-mode
    :interpreter "node"
    :defer t))

(defun m|indent-json ()
  (let ((indent-line-function 'js-indent-line))
    (indent-for-tab-command)))
