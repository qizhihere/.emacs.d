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
  (m|add-startup-hook #'show-paren-mode)
  (loaded subword (diminish 'subword-mode))
  (loaded simple (diminish 'auto-fill-function))
  (loaded autorevert (diminish 'auto-revert-mode))
  (loaded abbrev (diminish 'abbrev-mode))
  (bind-keys ("RET" . newline-and-indent)
             ("C-c s" . sort-lines))

  (use-package hideshow
    :defer t
    :diminish hs-minor-mode
    :config
    (m|be-quiet hs-show-all))

  (when (fboundp 'global-prettify-symbols-mode)
    (m|add-startup-hook #'global-prettify-symbols-mode)))

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
  (defun m|prog-mode-prepare-edit ()
    (hs-minor-mode 1)
    (setq show-trailing-whitespace t)
    (highlight-numbers-mode 1)
    (rainbow-delimiters-mode 1))
  (add-hook 'prog-mode-hook #'m|prog-mode-prepare-edit))

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
    (loaded spaceline (setq spaceline-anzu-p nil))))

(defun edit/init-smartparens ()
  (use-package smartparens
    :defer t
    :diminish smartparens-mode
    :init
    (m|add-startup-hook #'smartparens-global-mode)

    :config
    ;; disable default quote pair in certain modes
    (dolist (mode '(text-mode minibuffer-inactive-mode))
      (sp-local-pair mode "'" "")
      (sp-local-pair mode "`" ""))

    ;; advice to temporarily disable smartparens
    (defvar smartparens-temp-disabled nil)
    (defun m|smartparens-temp-disable (&rest args)
      "Temporary disable smartparens during ac-php-company completion."
      (when smartparens-mode
        (smartparens-mode -1)
        (setq-local smartparens-temp-disabled t)))
    (defun m|smartparens-maybe-reenable (&rest args)
      (when smartparens-temp-disabled
        (setq-local smartparens-temp-disabled nil)
        (smartparens-mode 1)))

    ;; disable smartparens during company completion
    (loaded company
      (add-hook 'company-completion-started-hook #'m|smartparens-temp-disable)
      (advice-add 'company-cancel :after #'m|smartparens-maybe-reenable))

    ;; enable smartparens in eval expression minibuffer
    (defun m|eval-expression-minibuffer-enable-smartparens ()
      (let (sp-ignore-modes-list)
        (smartparens-mode 1)))
    (add-hook 'eval-expression-minibuffer-setup-hook
              #'m|eval-expression-minibuffer-enable-smartparens)))

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
    (setq highlight-symbol-idle-delay 1.0)

    ;; if evil is available then remap * and #
    (loaded evil
      (bind-keys :map evil-normal-state-map
        ("*" . highlight-symbol-next)
        ("#" . highlight-symbol-prev)))))

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
    :init
    (add-hook 'prog-mode-hook
              (lambda () (unless (string-match-p "^\\*[^*]+\\*\\'" (buffer-name))
                       (whitespace-mode 1))))
    :bind (("C-c tmw" . whitespace-mode))
    :leader ("tmw" whitespace-mode)
    :diminish whitespace-mode
    :config
    (setq whitespace-default-style whitespace-style
          whitespace-style '(face tabs tab-mark)))

  (defun m|whitespace-cleanup ()
    (case (bound-and-true-p m|whitespace-cleanup-style)
      ('all (save-excursion
              (let ((whitespace-style
                     (or (bound-and-true-p whitespace-default-style)
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
             "tmr" read-only-mode)
    :bind (("M-j" . join-next-line)
           ("S-<return>" . open-next-line)
           ("C-<return>" . open-previous-line)
           ("M-B" . backward-symbol)
           ("M-F" . forward-symbol)
           ([remap beginning-of-line] . first-char-or-beginning-of-line)
           ("C-h V" . describe-variable-at-point)
           ("C-h F" . describe-function-at-point)))
  (advice-add 'kill-line :before #'kill-line--just-one-space))
