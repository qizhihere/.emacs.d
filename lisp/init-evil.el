(require 'cl)
(after-init (my/require '(evil evil-anzu)))

;; enable evil normal state in these modes
(setq evil-normal-state-modes
      '(prog-mode
        web-mode
        text-mode
        nginx-mode
        org-mode
        yaml-mode))

(after-load 'evil
  (dolist (mode '(view-mode))
    (add-to-list 'evil-emacs-state-modes mode)))

(defun should-be-evil-normal-state ()
  "Check if we should change evil to normal state according to
current active modes."
  (cl-flet ((derived-p (a b) (let ((major-mode b))
                               (derived-mode-p a))))
    (let ((active-modes (append (list major-mode)
                                (remove-if-not (lambda (x) (and (boundp x) (symbol-value x))) minor-mode-list)))
          (allowed-modes evil-normal-state-modes)
          (disallowed-modes evil-emacs-state-modes))
      (and (not (intersection active-modes disallowed-modes :test #'derived-p))
           (intersection active-modes allowed-modes :test #'derived-p)))))

(after-load 'evil
  ;; check if evil should be normal state when initializing evil
  (defadvice evil-initialize (after my/evil-initialize activate)
    (evil-change-state (if (should-be-evil-normal-state) 'normal 'emacs)))

  (defadvice evil-indent (around my/evil-indent activate)
    (let ((pos (point)))
      ad-do-it
      (goto-char pos)))

  ;; set evil default state to emacs
  (setq evil-default-state 'emacs
        evil-move-cursor-back nil)

  ;; keep some common keys of emacs in insert state
  (let ((evil-common-keys
         '(("C-a"  beginning-of-line)
           ("C-e"  end-of-line)
           ("C-p"  previous-line)
           ("C-n"  next-line)
           ("C-k"  kill-line)
           ("C-y"  yank)
           ("C-w"  kill-region)
           ("M-a"  backward-sentence)
           ("M-e"  forward-sentence)
           ("C-d"  delete-char)
           ("M-d"  kill-word)
           ("M-<DEL>" backward-kill-word))))

    (dolist (bind evil-common-keys)
      (dolist (m '(evil-insert-state-map
                   evil-operator-state-map
                   evil-replace-state-map
                   evil-normal-state-map))
        (define-key (symbol-value m) (kbd (car bind)) (cadr bind)))))

  ;; quick indent
  (defun my/evil-indent-paragraph (&rest args)
    (interactive)
    (let* ((orig-state evil-state)
           (to-state (symbol-concat 'evil- orig-state '-state)))
      (evil-normal-state)
      (my/send-keys "=ap")
      (when (fboundp to-state)
        (funcall to-state))))

  (add-hook 'prog-mode-hook
            (lambda () (dolist (mode '(evil-insert-state-local-map
                                   evil-normal-state-local-map))
                     (define-key (symbol-value mode) (kbd "C-c C-c") 'my/evil-indent-paragraph))))


  (define-key evil-normal-state-map (kbd "C-c C-c") 'my/evil-indent-paragraph)
  ;; text scale map
  (define-key evil-normal-state-map "+" 'text-scale-increase)
  (define-key evil-normal-state-map "-" 'text-scale-decrease))

(after-init (evil-mode 1))


;; remap escape key
(my/install 'key-chord)
(after-load 'evil
  (setq key-chord-two-keys-delay 0.4)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
  (key-chord-define evil-emacs-state-map "jk" 'evil-normal-state)
  (key-chord-define evil-visual-state-map "jk" 'evil-normal-state)
  (silently-do (key-chord-mode 1)))


;;-----------------------
;; evil-leader
;;-----------------------
(my/install 'evil-leader)
(after-load 'evil
  (global-evil-leader-mode t)
  (evil-leader/set-leader ";")
  ;; remap * and #
  (define-key evil-motion-state-map "*" 'highlight-symbol-next)
  (define-key evil-motion-state-map "#" 'highlight-symbol-prev))


;;-----------------------
;; evil-args
;;-----------------------
(my/install 'evil-args)

(after-load 'evil
  ;; bind evil-args text objects
  (define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
  (define-key evil-outer-text-objects-map "a" 'evil-outer-arg)

  ;; bind evil-forward/backward-args
  (define-key evil-normal-state-map "L" 'evil-forward-arg)
  (define-key evil-normal-state-map "H" 'evil-backward-arg)
  (define-key evil-motion-state-map "L" 'evil-forward-arg)
  (define-key evil-motion-state-map "H" 'evil-backward-arg)

  ;; bind evil-jump-out-args
  (define-key evil-normal-state-map "K" 'evil-jump-out-args))

;;-----------------------
;; evil-matchit
;;-----------------------
(my/install 'evil-matchit)
(after-load 'evil
  (global-evil-matchit-mode 1))


;;-----------------------
;; evil-exchange
;;-----------------------
(my/install 'evil-exchange)
(after-load 'evil
  (setq evil-exchange-key (kbd "zx"))
  (evil-exchange-install))


;;-----------------------
;; evil-snipe
;;-----------------------
(my/install 'evil-snipe)
(after-load 'evil
  (after-load' evil-snipe (diminish 'evil-snipe-mode))
  (evil-snipe-mode 1)
  (setq evil-snipe-repeat-keys t
        evil-snipe-scope 'visible
        evil-snipe-repeat-scope 'whole-visible
        evil-snipe-enable-highlight t
        evil-snipe-enable-incremental-highlight t))


;;-----------------------
;; evil-surround
;;-----------------------
(my/install 'evil-surround)
(after-load 'evil
  (global-evil-surround-mode 1))

;;----------------------------------------------------------------------------
;; evil jumper
;;----------------------------------------------------------------------------
(my/install 'evil-jumper)
(after-load 'evil
  (evil-jumper-mode 1))




(provide 'init-evil)
