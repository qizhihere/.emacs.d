;;----------------------------------------------------------------------------
;; mode line format
;;----------------------------------------------------------------------------
(my/install 'window-numbering)

(defun my/window-numbering-mode-line ()
  "Get mode line string for window-numbering."
  (ignore-errors
    `(" " (:propertize
           ,(concat "[" (number-to-string (window-numbering-get-number)) "]")
           face window-numbering-face))))

(defun my/vc-mode-line ()
  "Get mode line string for version control."
  (ignore-errors
    `(" " (:propertize
           ,(let ((backend (symbol-name (vc-backend (buffer-file-name)))))
              (substring vc-mode (+ (length backend) 2)))
           face font-lock-keyword-face))))

(defvar my/projectile-mode-line
  '(:propertize
    (:eval (when (ignore-errors (projectile-project-root))
             (concat " " (projectile-project-name))))
    face (font-lock-keyword-face bold))
  "Mode line format for Projectile.")

(defun my/wg-mode-line ()
  "Get mode line string for workgroups2."
  (ignore-errors
    (let ((wg-mode-line-decor-left-brace "")
          (wg-mode-line-decor-right-brace "")
          (wg-string (replace-regexp-in-string "[ \t\n]" "" (wg-mode-line-string))))
      (and (not (string= "" wg-string))
           `("[" (-13 ,wg-string "]"))))))

(dolist (var '(my/vc-mode-line
               my/projectile-mode-line))
  (put var 'risky-local-variable t))

(setq-default mode-line-position '(+12 (line-number-mode
                                        (-12 "%l" (+3 (column-number-mode ":%c"))))
                                       (-4 " %p"))
              mode-line-format
              '("%e"
                (eldoc-mode-line-string (" " eldoc-mode-line-string " "))
                ;; window-numbering
                (:eval (my/window-numbering-mode-line))
                ;; evil state tag
                (:eval (ignore-errors evil-mode-line-tag))
                " "
                mode-line-mule-info
                mode-line-client
                mode-line-modified
                mode-line-remote
                mode-line-frame-identification
                ;; buffer file and file size
                (-60 (+60
                      (+22 (-25
                            (:eval (propertized-buffer-identification "%b")))
                           "  " (size-indication-mode (-4 "%I")))
                      "   "
                      mode-line-position
                      ;; projectile and git
                      (+16 (-6 (vc-mode (:eval (my/vc-mode-line))))
                           (-16 (:eval my/projectile-mode-line)))))
                " "
                (+15 (:eval (my/wg-mode-line)))
                " "
                (+24 (-24 (:eval mode-line-modes)))
                " "
                mode-line-misc-info
                mode-line-end-spaces))



(provide 'init-mode-line)
