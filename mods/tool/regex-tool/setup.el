(setq regex-tool-packages '(regex-tool))

(defun regex-tool/init ()
  (use-package regex-tool
    :defer t
    :evil (:map (regex-tool-mode-map :defer t) :defer nil
           ("Q" . regex-tool-quit))))
