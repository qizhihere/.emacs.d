(setq dictionary-packages '(youdao-dictionary))

(defun dictionary/init ()
  (use-package youdao-dictionary
    :leader ("sd" youdao-dictionary-search-at-point+)
    :bind (("C-c y" . youdao-dictionary-search-at-point+))
    :config
    (setq url-automatic-caching t)))
