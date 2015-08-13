(my/require 'emms)

(require 'emms-setup)
(require 'emms-playlist-sort)
(require 'emms-history)
(require 'emms-mode-line)

(my/mkrdir '("session/emms"))

(setq emms-directory (my/init-dir "session/emms")
      emms-lyrics-dir "~/Music/lyrics"
      emms-source-file-default-directory "~/Music/"
      emms-playlist-buffer-name "*Music*"
      emms-history-file (my/init-dir "session/emms/emms-history"))

(emms-standard)
(emms-default-players)
(emms-history-load)
(emms-mode-line 1)

;; set mode line
(defun my/emms-mode-line-function ()
  (let* ((str (emms-info-track-description
	       (emms-playlist-current-selected-track)))
	 (str (replace-regexp-in-string "/.*/" "" str))
	 (str (replace-regexp-in-string " +" ""
		(replace-regexp-in-string "\.[a-zA-Z0-9]+$" "" str)))
	 (str (replace-regexp-in-string ".+?-" "" str))
	 (is-abbr (<= (length str) 8))
	 (len (if is-abbr (length str) 8)))
    (concat " \u266a " (substring str 0 len) (if is-abbr "+") " ")))
(setq emms-mode-line-mode-line-function
      'my/emms-mode-line-function
      emms-mode-line-format "%s")

;; set hooks
(defun my/emms-started-hooks ()
  (if (string= (buffer-name) emms-playlist-buffer-name)
      (emms-playlist-mode-center-current))
  (my/system-notify
   "Emms playing..."
   (emms-track-description (emms-playlist-current-selected-track))))

(add-hook 'emms-player-started-hook 'my/emms-started-hooks)

;; bind keys
(define-key emms-playlist-mode-map (kbd "R") 'emms-toggle-random-playlist)
(define-key emms-playlist-mode-map (kbd "Sa") 'emms-playlist-sort-by-info-artist)
(define-key emms-playlist-mode-map (kbd "Sn") 'emms-playlist-sort-by-name)
(define-key emms-playlist-mode-map (kbd "St") 'emms-playlist-sort-by-info-title)
(define-key emms-playlist-mode-map (kbd "+") 'emms-volume-mode-plus)
(define-key emms-playlist-mode-map (kbd "-") 'emms-volume-mode-minus)
(global-set-key (kbd "<XF86AudioPlay>") 'emms-pause)
(global-set-key (kbd "<XF86AudioStop>") 'emms-stop)
(global-set-key (kbd "<XF86AudioPrev>") 'emms-previous)
(global-set-key (kbd "<XF86AudioNext>") 'emms-next)


(provide 'init-emms)
