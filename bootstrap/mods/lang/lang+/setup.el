(setq lang+-packages '(conf-mode
                       vimrc-mode
                       yaml-mode
                       lua-mode
                       dockerfile-mode
                       nginx-mode))

(defun lang+/init-nginx()
  (use-package nginx-mode
    :defer t
    :mode "/nginx/.+"))
