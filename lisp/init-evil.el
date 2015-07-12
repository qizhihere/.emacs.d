(lqz/require 'evil)
(lqz/require 'evil-anzu) ;; show search info in evil-mode

;; enable evil in most programming modes
(evil-mode 1)

;; disable evil in certain modes
(add-more-to-list 'evil-emacs-state-modes
    '(dired-mode org-mode eww-mode package-menu-mode help-mode Man-mode
      Custom-mode custom-theme-choose-mode apropos-mode pyim-dicts-manager-mode
      git-timemachine-mode rxt-help-mode org-src-mode))

;; remap escape key
(lqz/require 'key-chord)
(setq key-chord-two-keys-delay 0.4)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-emacs-state-map "jk" 'evil-normal-state)
(key-chord-define evil-visual-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)


;;-----------------------
;; evil-leader
;;-----------------------
(lqz/require 'evil-leader)

(global-evil-leader-mode t)
(evil-leader/set-leader ";")

;; remap * and #
(define-key evil-motion-state-map "*" 'highlight-symbol-next)
(define-key evil-motion-state-map "#" 'highlight-symbol-prev)


;;-----------------------
;; evil-args
;;-----------------------
(lqz/require 'evil-args)

;; bind evil-args text objects
(define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
(define-key evil-outer-text-objects-map "a" 'evil-outer-arg)

;; bind evil-forward/backward-args
(define-key evil-normal-state-map "L" 'evil-forward-arg)
(define-key evil-normal-state-map "H" 'evil-backward-arg)
(define-key evil-motion-state-map "L" 'evil-forward-arg)
(define-key evil-motion-state-map "H" 'evil-backward-arg)

;; bind evil-jump-out-args
(define-key evil-normal-state-map "K" 'evil-jump-out-args)

;; use Q to quit window in evil mode
(define-key evil-normal-state-map "Q" 'quit-window)


;;-----------------------
;; evil-matchit
;;-----------------------
(lqz/require 'evil-matchit)
(global-evil-matchit-mode 1)


;;-----------------------
;; evil-exchange
;;-----------------------
(lqz/require 'evil-exchange)
(setq evil-exchange-key (kbd "zx"))
(evil-exchange-install)


;;-----------------------
;; evil-snipe
;;-----------------------
(lqz/require 'evil-snipe)
(evil-snipe-mode 1)
(setq evil-snipe-repeat-keys t)
(setq evil-snipe-scope 'visible)
(setq evil-snipe-repeat-scope 'whole-visible)
(setq evil-snipe-enable-highlight t)
(setq evil-snipe-enable-incremental-highlight t)


;;-----------------------
;; evil-surround
;;-----------------------
(lqz/require 'evil-surround)
(global-evil-surround-mode 1)


;;-----------------------
;; evil-nerd-commenter
;;-----------------------
(lqz/require 'evil-nerd-commenter)
(evilnc-default-hotkeys)
;; emacs key bindings
(global-set-key (kbd "M-;")	'evilnc-comment-or-uncomment-lines)
(global-set-key (kbd "C-c l")	'evilnc-quick-comment-or-uncomment-to-the-line)



(provide 'init-evil)
