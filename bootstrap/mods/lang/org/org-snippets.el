(defun org-expand(str)
  "Expand org template."
  (insert str)
  (org-try-structure-completion))

(defun org-insert-src (&optional lang)
  "Quickly insert src block in org-mode."
  (org-expand "<s")
  (if lang (insert lang) (delete-char -1))
  (next-line))
