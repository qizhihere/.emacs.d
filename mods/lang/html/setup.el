(setq html-packages '(web-mode
                      company-web
                      web-beautify
                      emmet-mode))
(defun html/init ())

(defun html/init-web-mode ()
  (use-package web-mode
    :mode "\\.\\(blade\\.\\|\\(html\\|xml\\|jsp\\|erb\\|tpl\\|j2\\)\\'\\)\\|views/.+\\.php"
    :config
    (setq web-mode-markup-indent-offset 2
          web-mode-code-indent-offset 2
          web-mode-css-indent-offset 2
          web-mode-comment-style 2
          web-mode-enable-auto-pairing nil
          web-mode-enable-current-element-highlight t
          web-mode-enable-current-column-highlight t)

    (setq web-mode-engines-alist
          '(("php"    . "\\.tpl\\'")
            ("blade"  . "\\.blade\\."))))

  (loaded evil
    (add-to-list 'evil-fold-list
                 '((web-mode)
                   :opel-all web-mode-element-children-fold-or-unfold
                   :close-all web-mode-element-children-fold-or-unfold
                   :toggle web-mode-fold-or-unfold
                   :open web-mode-fold-or-unfold
                   :close web-mode-fold-or-unfold))))

(defun html/init-smartparens ()
  (loaded smartparens
    (sp-local-pair 'web-mode "<%" "%>")
    (sp-local-pair 'web-mode "<% " " %>")))

(defun html/init-emmet ()
  (use-package emmet-mode
    :defer t
    :diminish emmet-mode
    :init
    (add-hooks
     '(html-mode-hook
       nxml-mode-hook
       jade-mode-hook
       css-mode-hook
       web-mode-hook)
     #'emmet-mode)
    :config
    (setq emmet-preview-default nil)))

(defun html/init-web-beautify ()
  (use-package web-beautify :defer t))
