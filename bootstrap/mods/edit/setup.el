(setq edit-packages
      '(ace-link
        aggressive-indent
        anzu
        comment-dwim-2
        drag-stuff
        highlight-numbers
        highlight-parentheses
        highlight-symbol
        page-break-lines
        rainbow-delimiters
        rainbow-mode
        smartparens))

(defun edit/init ()
  ;; replaced by `show-smartparens-mode'
  (m|add-startup-hook #'show-paren-mode)
  (bind-keys ("RET" . newline-and-indent)
             ("C-c s" . sort-lines)
             ("<f3>" . indent-buffer))

  (use-package hideshow
    :defer t
    :diminish hs-minor-mode
    :config
    (m|be-quiet hs-show-all)))

(defun edit/init-prettify-symbol ()
  (loaded prog-mode
    (setq prettify-symbols-unprettify-at-point 'right-edge)

    (defun m|prog-prettify-symbols ()
      (merge-to prettify-symbols-alist
        '(("<=" . (?\s (Br . Bl) ?\s (Bc . Bc) ?⩽))
          (">=" . (?\s (Br . Bl) ?\s (Bc . Bc) ?⩾)))))
    (add-hook 'prog-mode-hook #'m|prog-prettify-symbols)
    (global-prettify-symbols-mode 1)))

(defun edit/init-diminish ()
  (loaded abbrev (diminish 'abbrev-mode))
  (loaded autorevert (diminish 'auto-revert-mode))
  (loaded compile (diminish 'compilation-shell-minor-mode))
  (loaded hideif (diminish 'hide-ifdef-mode))
  (loaded simple (diminish 'auto-fill-function))
  (loaded subword (diminish 'subword-mode)))

(defun edit/init-aggressive-indent ()
  (use-package aggressive-indent
    :defer t
    :diminish aggressive-indent-mode)

  (defvar m|aggressive-indent-max-lines 1000)
  (defun m|try-turn-on-aggressive-indent ()
    (when (< (count-lines (point-min) (point-max))
             m|aggressive-indent-max-lines)
      (aggressive-indent-mode 1)))
  (add-hook 'emacs-lisp-mode-hook #'m|try-turn-on-aggressive-indent))

(defun edit/init-prog-mode-hooks ()
  (add-hooks 'prog-mode-hook
             '(hs-minor-mode
               highlight-numbers-mode
               rainbow-delimiters-mode)))

(defun edit/init-anzu ()
  (loaded isearch (global-anzu-mode 1))
  (use-package anzu
    :diminish anzu-mode
    :bind (([remap query-replace] . anzu-query-replace)
           ([remap query-replace-regexp] . anzu-query-replace-regexp))
    :config
    ;; replace isearch mode lighter with anzu search info
    (setq anzu-cons-mode-line-p nil)
    (setcar (cdr (assq 'isearch-mode minor-mode-alist))
            '(:eval (anzu--update-mode-line)))

    ;; turn off spaceline anzu segment if there is
    (loaded spaceline-segments (setq spaceline-anzu-p nil))))

(defun edit/init-smartparens ()
  (use-package smartparens
    :diminish smartparens-mode
    :init
    (m|add-startup-hook #'smartparens-global-mode)
    :bind (:map smartparens-mode-map
           ("C-M-a" . sp-beginning-of-sexp)
           ("C-M-e" . sp-end-of-sexp)
           ("C-M-n" . sp-next-sexp)
           ("C-M-p" . sp-previous-sexp)
           ("C-S-f" . sp-forward-symbol)
           ("C-S-b" . sp-backward-symbol)
           ("C-M-w" . sp-copy-sexp)
           ("M-]"   . sp-unwrap-sexp))
    :config
    ;; disable smartparens verbose messages
    (setq sp-message-width nil)

    ;; only enable in ruby-mode because of its low performance
    (add-hook 'ruby-mode-hook
              (lambda () (when (<= (count-screen-lines) 100)
                       (show-smartparens-mode 1))))
    (m|load-conf "setup-smartparens" edit))

  (use-package setup-smartparens
    :ensure nil
    :commands (m|smartparens-temp-disable
               m|smartparens-maybe-reenable)
    :bind (:map smartparens-mode-map
           ("C-c ("  . sp-wrap-with-parens)
           ("C-c ["  . sp-wrap-with-brackets)
           ("C-c {"  . sp-wrap-with-braces)
           ("C-c '"  . sp-wrap-with-single-quotes)
           ("C-c \"" . sp-wrap-with-double-quotes)
           ("C-c _"  . sp-wrap-with-underscores)
           ("C-c `"  . sp-wrap-with-back-quotes))))

(defun edit/init-highlight-parentheses ()
  (use-package highlight-parentheses
    :init
    (add-hook 'prog-mode-hook #'highlight-parentheses-mode)
    :diminish highlight-parentheses-mode))

(defun edit/init-highlight-symbol ()
  (use-package highlight-symbol
    :defer t
    :diminish highlight-symbol-mode
    :init
    (add-hook 'prog-mode-hook 'highlight-symbol-mode)
    :config
    (setq highlight-symbol-idle-delay 1.0)))

(defun edit/init-rainbow-mode ()
  (use-package rainbow-mode
    :defer t
    :diminish rainbow-mode
    :init
    (add-hook 'prog-mode-hook 'rainbow-mode)))

(defun edit/init-page-break-lines-mode ()
  (use-package page-break-lines
    :diminish page-break-lines-mode
    :init
    (m|add-startup-hook #'global-page-break-lines-mode)))

(defun edit/init-comment-dwim-2 ()
  (use-package comment-dwim-2
    :bind (("M-;" . comment-dwim-2))))

(defun edit/init-drag-stuff ()
  (use-package drag-stuff
    :defer t
    :diminish drag-stuff-mode
    :init
    (add-hook 'prog-mode-hook #'turn-on-drag-stuff-mode)
    :config
    (m|load-conf "setup-drag-stuff" edit)))

(defun edit/init-ace-link ()
  (m|add-startup-hook #'ace-link-setup-default))

(defun edit/init-whitespace ()
  (use-package whitespace
    ;; :init
    ;; (add-hook 'prog-mode-hook
    ;;           (lambda () (unless (string-match-p "^\\*[^*]+\\*\\'" (buffer-name))
    ;;                    (whitespace-mode 1))))
    :bind (("C-c tmw" . whitespace-mode))
    :leader ("tmw" whitespace-mode)
    :diminish whitespace-mode
    :config
    (setq whitespace-cleanup-style whitespace-style
          whitespace-style '(face tabs trailing tab-mark)))

  (defun m|whitespace-cleanup ()
    (case (bound-and-true-p m|whitespace-cleanup-style)
      ('all (save-excursion
              (let ((whitespace-style
                     (or (bound-and-true-p whitespace-cleanup-style)
                         whitespace-style)))
                (whitespace-cleanup))))
      ('trailing (save-excursion (call-interactively
                                  #'delete-trailing-whitespace)))))
  (add-hook 'before-save-hook #'m|whitespace-cleanup))

(defun edit/init-pratical-edit-utils ()
  (use-package edit-utils
    :ensure nil
    :commands kill-line--just-one-space
    :load-path (lambda () (__dir__))
    :leader ("re" query-replace-from-region-or-symbol
             "tmr" read-only-mode
             "tot" toggle-truncate-lines)
    :bind (("M-j" . join-next-line)
           ("S-<return>" . open-next-line)
           ("C-<return>" . open-previous-line)
           ("M-B" . backward-symbol)
           ("M-F" . forward-symbol)
           ("C-a" . first-char-or-beginning-of-line)
           ([remap beginning-of-line] . first-char-or-beginning-of-line)
           ("C-h V" . describe-variable-at-point)
           ("C-h F" . describe-function-at-point)))
  (advice-add 'kill-line :before #'kill-line--just-one-space))

(defun edit/init-hexl ()
  (loaded hexl
    (defun m|inhibit-hexlify-buffer-prompt (orig-func &rest args)
      (let (buffer-undo-list)
        (apply orig-func args)))
    (advice-add 'hexlify-buffer :around #'m|inhibit-hexlify-buffer-prompt)))
