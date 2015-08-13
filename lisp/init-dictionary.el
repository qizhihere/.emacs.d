;;----------------------------------------------------------------------------
;; youdao dict
;;----------------------------------------------------------------------------
(my/install 'youdao-dictionary)

;; enable cache
(setq url-automatic-caching t)

(global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point+)



(provide 'init-dictionary)
