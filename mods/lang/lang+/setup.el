(setq lang+-packages '(conf-mode
                       vimrc-mode
                       yaml-mode
                       lua-mode
                       dockerfile-mode
                       nginx-mode
                       protobuf-mode
                       crontab-mode))

(defun lang+/init ()
  )

(defun lang+/init-nginx ()
  (use-package nginx-mode
    :defer t
    :mode "/nginx/.+"))

(defun lang+/init-crontab ()
  (use-package crontab-mode
    :defer t
    :mode "crontab\\(\\..+\\)?$"
    :config
    (unbind-key "C-c c" crontab-mode-map)))
