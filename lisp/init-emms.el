(lqz/require 'emms)

(require 'emms-setup)

(emms-standard)
(emms-default-players)

(setq emms-directory (lqz/init-dir "emms")
      emms-lyrics-dir "~/Music/lyrics"
      emms-source-file-default-directory "~/Music/")

;; bind keys
(global-set-key (kbd "<XF86AudioPlay>") 'emms-pause)
(global-set-key (kbd "<XF86AudioStop>") 'emms-stop)
(global-set-key (kbd "<XF86AudioPrev>") 'emms-previous)
(global-set-key (kbd "<XF86AudioNext>") 'emms-next)


(provide 'init-emms)
