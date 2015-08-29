(my/install '(web-beautify web-mode))

(after-load "web-mode"
  (setq web-mode-markup-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-comment-style 2
        web-mode-enable-auto-pairing t
        web-mode-enable-current-element-highlight t)
  ;; set template engines
  (setq web-mode-engines-alist
        '(("php"    . "\\.tpl\\'")
          ("blade"  . "\\.blade\\."))))

(add-auto-mode 'web-mode "\\.\\(jsp\\|tmpl\\|tpl\\|blade\\.php\\)\\'")

(my/install '(jade-mode sws-mode))
(add-auto-mode 'jade-mode "\\.jade\\'")
(add-auto-mode 'sws-mode "\\.styl\\'")
(dolist (mode '(jade-mode web-mode sws-mode))
  (eval `(after-load ',mode
           (derive-from-prog-mode ',mode))))

(my/install 'emmet-mode)
(with-installed 'helm
  (my/try-install 'helm-emmet))
(dolist (hook '(html-mode-hook jade-mode-hook css-mode-hook web-mode-hook))
  (and (boundp hook) (add-hook hook 'emmet-mode)))

(with-installed 'company
  (when (my/try-install 'company-web)
    (after-load 'company
      (add-to-list 'company-backends 'company-web-html)
      (add-to-list 'company-backends 'company-web-jade)
      (add-to-list 'company-backends 'company-web-slim))))



(provide 'init-html)
