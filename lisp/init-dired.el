(lqz/require '(dired+ dired-details+ dired-efap dired-filter dired-rainbow))

;; make dired only use single buffer
(toggle-diredp-find-file-reuse-dir 1)

;; use the directory in the next dired window as default directory
(setq dired-dwim-target t)

;; dired rename and filter
(define-key dired-mode-map (kbd "r") 'dired-efap)
(define-key dired-mode-map (kbd "F") dired-filter-map)

;; define some file extensions
(defvar text-file-name-extensions
  (purecopy '("txt" "md" "org")))
(defvar doc-file-name-extensions
  (purecopy '("pdf" "doc" "docx" "xls" "xlsx" "ppt" "xml" "htm" "html")))
(defvar code-file-name-extensions
  (purecopy '("h" "c" "cxx" "cpp" "el" "pl" "py" "pm")))
(defvar audio-file-name-extensions
  (purecopy '("mp3" "ogg" "wav" "wma" "flac" "aac" "ape" "aif")))
(defvar video-file-name-extensions
  (purecopy '("mp4" "mov" "mkv" "avi" "rmvb" "rm" "wmv" "3gp" "vob"
			  "mpg" "mpeg" "divx" "ogm" "ogv" "asf" "flv" "webm")))

;; use dired-rainbow to color dired file list
(dired-rainbow-define text "white smoke"
	text-file-name-extensions)
(dired-rainbow-define doc "light gray"
	doc-file-name-extensions)
(dired-rainbow-define code "wheat"
	code-file-name-extensions)
(dired-rainbow-define audio "tomato"
	audio-file-name-extensions)
(dired-rainbow-define video "gold"
	video-file-name-extensions)



(provide 'init-dired)
