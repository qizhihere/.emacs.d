;;-----------------------
;; youdao dict
;;-----------------------
(lqz/require 'youdao-dictionary)

;; enable cache
(setq url-automatic-caching t)
;; Set file path for saving search history
(setq youdao-dictionary-search-history-file (lqz/init-dir "tmp/.youdao"))

(global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point+)


;;-----------------------
;; google translate
;;-----------------------
(lqz/require 'google-translate)

(setq google-translate-translation-directions-alist
      '(("en" . "zh-CN") ("zh-CN" . "en")))
(setq google-translate-preferable-input-methods-alist
      '((nil . ("en"))
	(chinese-pyim . ("zh-CN"))))

(setq google-translate-default-source-language "auto"
      google-translate-default-target-language "zh-CN"
      google-translate-output-destination      'popup
      google-translate-show-phonetic		    t)

(global-set-key (kbd "C-c t") 'google-translate-smooth-translate)
(global-set-key (kbd "C-c T") 'google-translate-query-translate)



(provide 'init-dictionary)
