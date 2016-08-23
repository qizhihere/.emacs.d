(setq theming-packages '(beacon
                         spacemacs-theme
                         zoom-frm))

(add-to-list 'load-path (file-name-directory load-file-name))
(add-to-list 'custom-theme-load-path (file-name-directory load-file-name))

(defconst m|initial-frame (selected-frame)
  "Initial frame during Emacs startup.")

(defun theming/init ()
  (setq default-frame-alist '((width . 80)
                              (height . 30)))
  (unless (not (bound-and-true-p m|boot-maximized))
    (add-to-list 'initial-frame-alist '(fullscreen . maximized))
    (add-hook 'window-setup-hook #'maximize-frame)))

(defun theming/init-frame ()
  ;; disable dialogs
  (setq-default
   use-file-dialog nil
   use-dialog-box nil)
  ;; hide bars
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)

  ;; apply theme to frame
  (add-hook 'after-make-frame-functions #'theming|frame-apply-theme)
  (add-hook 'after-make-frame-functions #'theming|frame-setup-fonts)
  (theming|frame-apply-theme)
  (theming|frame-setup-fonts))

(defun theming|frame-apply-theme (&optional frame)
  (with-selected-frame (or frame (selected-frame))
    (let ((theme m|gui-color-theme)
          (theme-rev m|console-color-theme))
      (unless window-system
        (setq theme m|console-color-theme
              theme-rev m|gui-color-theme))
      (load-theme theme t t)
      (enable-theme theme)
      (when (not (eq theme theme-rev))
        (disable-theme theme-rev)))))

(defun theming|frame-setup-fonts (&optional frame)
  (with-selected-frame (or frame (selected-frame))
    (when window-system
      ;; default font
      (set-face-attribute 'default nil
                          :font (format "%s %s" (car m|gui-font)
                                        (plist-get (cdr m|gui-font) :size)))
      ;; chinese font
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
        (set-fontset-font (frame-parameter nil 'font)
                          charset
                          (font-spec :family (car m|gui-chinese-font)
                                     :size (plist-get (cdr m|gui-chinese-font) :size))))
      ;; unicode symbols fallback font
      (set-fontset-font "fontset-default" nil (font-spec :size 20 :name "Symbola")))))

(defun theming/init-zoom ()
  (use-package zoom-frm
    :bind (("<M-mouse-4>" . zoom-frm-in)
           ("<M-mouse-5>" . zoom-frm-out)
           ("<M-mouse-2>" . zoom-frm-unzoom)))

  (bind-keys ("<C-mouse-4>" . text-scale-increase)
             ("<C-mouse-5>" . text-scale-decrease)))

(defun theming/init-beacon ()
  (use-package beacon
    :defer t
    :init
    (m|add-startup-hook #'beacon-mode)
    :config
    (setq beacon-blink-when-window-scrolls nil)
    (merge-to beacon-dont-blink-major-modes
      '(debugger-mode
        term-mode
        ggtags-global-mode))))

(defun theming/init-spacemacs-theme ()
  (use-package spacemacs-dark-theme
    :ensure spacemacs-theme
    :defer t
    :config
    (custom-theme-set-faces
     'spacemacs-dark
     '(show-paren-match ((t (:inherit (sp-show-pair-match-face highlight)))))
     '(highlight-symbol-face ((t (:background "#2c2c2c"))))
     '(font-lock-doc-face ((t (:background nil))))
     '(font-lock-string-face ((t (:background nil))))
     '(linum-relative-current-face ((t (:background "#292b2e"))))
     '(git-gutter:added ((t (:background nil))))
     '(git-gutter:deleted ((t (:background nil))))
     '(git-gutter:modified ((t (:background nil)))))))
