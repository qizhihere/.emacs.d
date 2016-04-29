(setq theming-packages '(spacemacs-theme))

(add-to-list 'load-path (file-name-directory #$))
(add-to-list 'custom-theme-load-path (file-name-directory #$))

(defconst m|initial-frame (selected-frame)
  "Initial frame during Emacs startup.")

(defun theming/init ()
  (setq-default line-spacing 5)
  (setq default-frame-alist '((width . 80)
                              (height . 30))))

(defun theming/init-frame ()
  ;; disable dialogs
  (setq-default
   use-file-dialog nil
   use-dialog-box nil)
  ;; hide bars
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)

  ;; reapply theme after init
  ;; (add-hook 'after-init-hook #'theming|frame-apply-theme)

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
      (disable-theme theme-rev))))

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

(defun theming/init-spacemacs-theme ()
  (use-package spacemacs-dark-theme
    :ensure spacemacs-theme
    :defer t
    :config
    (custom-theme-set-faces
     'spacemacs-dark
     '(highlight-symbol-face ((t (:background "#2c2c2c"))))
     '(font-lock-doc-face ((t (:background nil))))
     '(font-lock-string-face ((t (:background nil))))
     '(linum-relative-current-face ((t (:background "#292b2e"))))
     '(git-gutter:added ((t :background nil)))
     '(git-gutter:deleted ((t :background nil)))
     '(git-gutter:modified ((t :background nil))))))
