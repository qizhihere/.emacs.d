(cond
 ((executable-find "aspell")
  (setq ispell-program-name "aspell")
  (setq ispell-extra-args '("--sug-mode=ultra")))
 ((executable-find "ispell")
  (setq ispell-program-name "ispell"))
 (t (setq ispell-program-name nil)))

(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(defadvice flyspell-mode (around start-flyspell-mode-silently activate)
  (silently-do ad-do-it))

(after-load 'flyspell
  (diminish 'flyspell-mode)
  (silently-do (ispell-change-dictionary "american" t))
  (with-installed 'helm
	(when (my/try-install 'helm-flyspell)
	  (define-key flyspell-mode-map [M-tab] 'helm-flyspell-correct))))

(after-load 'ispell (diminish 'ispell-minor-mode))


(provide 'init-flyspell)
