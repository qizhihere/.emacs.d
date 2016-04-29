(setq edit-packages
      '(ace-link
        aggressive-indent
        anzu
        beacon
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
  (m|add-idle-hook #'global-hl-line-mode)
  (m|add-idle-hook #'show-paren-mode)
  (diminish 'subword-mode)
  (diminish 'auto-fill-function)
  (global-set-key (kbd "RET") #'newline-and-indent)

  (use-package hideshow
    :defer t
    :diminish hs-minor-mode
    :config
    (m|be-quiet hs-show-all))

  (when (fboundp 'global-prettify-symbols-mode)
    (m|add-idle-hook #'global-prettify-symbols-mode)))

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
    (loaded spaceline (spaceline-toggle-anzu-off))))

(defun edit/init-beacon ()
  (use-package beacon
    :defer t
    :init
    (m|add-idle-hook #'beacon-mode)
    :config
    (setq beacon-blink-when-window-scrolls nil)
    (add-to-list 'beacon-dont-blink-major-modes 'debugger-mode)))

(defun edit/init-smartparens ()
  (use-package smartparens
    :diminish smartparens-mode
    :init
    (m|add-idle-hook #'smartparens-global-mode)

    :config
    ;; disable default quote pair in certain modes
    (dolist (mode '(text-mode minibuffer-inactive-mode))
      (sp-local-pair mode "'" "")
      (sp-local-pair mode "`" ""))

    ;; enable smartparens in eval expression minibuffer
    (defun m|eval-expression-minibuffer-enable-smartparens ()
      (let (sp-ignore-modes-list)
        (smartparens-mode 1)))
    (add-hook 'eval-expression-minibuffer-setup-hook
              #'m|eval-expression-minibuffer-enable-smartparens)))

(defun edit/init-highlight-parentheses ()
  (use-package highlight-parentheses
    :init
    (m|add-idle-hook #'global-highlight-parentheses-mode)
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
    (m|add-idle-hook #'global-page-break-lines-mode)))

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
    (m|load-relative "setup-drag-stuff" #$)))

(defun edit/init-ace-link ()
  (m|add-idle-hook #'ace-link-setup-default))

(defun edit/init-whitespace-cleanup ()
  (message "whitespace clean hook added.")
  (defun m|whitespace-cleanup ()
    (case (bound-and-true-p m|whitespace-cleanup-style)
      ('all (save-excursion (whitespace-cleanup)))
      ('trailing (save-excursion (call-interactively
                                  #'delete-trailing-whitespace)))))
  (add-hook 'before-save-hook #'m|whitespace-cleanup)
  (message "before-save-hook: %s" before-save-hook))

(defun edit/init-pratical-edit-utils ()
  (use-package edit-utils
    :ensure nil
    :commands kill-line--just-one-space
    :load-path (lambda () (file-name-directory #$))
    :leader ("re" query-replace-from-region-or-symbol)
    :bind (("M-j" . join-next-line)
           ("S-<return>" . open-next-line)
           ("C-<return>" . open-previous-line)
           ("M-B" . backward-symbol)
           ("M-F" . forward-symbol)
           ([remap beginning-of-line] . first-char-or-beginning-of-line)))
  (advice-add 'kill-line :before #'kill-line--just-one-space))
