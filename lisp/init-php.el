(my/install '(php-mode php-eldoc))

;; php-extras is not available in melpa, use el-get to install it.
(unless (or (el-get-package-is-installed 'php-extras)
            (package-installed-p 'php-extras))
  (el-get-bundle arnested/php-extras)
  (when (require 'php-extras nil t)
    (unless (require 'php-extras-eldoc-functions php-extras-eldoc-functions-file t)
      (cl-letf (((symbol-function 'yes-or-no-p) (lambda (&rest args) t)))
        (php-extras-generate-eldoc)))))


(after-load 'php-mode
  (add-hook 'php-mode-hook
            (lambda () (subword-mode 1)
              (setq php-lineup-cascaded-calls t)
              (php-enable-default-coding-style)
              (php-eldoc-enable))))

;; try load ob-php
(ignore-errors
  (require 'ob-php))



(provide 'init-php)
