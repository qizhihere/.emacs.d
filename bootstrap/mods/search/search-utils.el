(defun m|search-github-code (keywords extension)
  "Search code in GitHub."
  (interactive
   (list
    (read-from-minibuffer "Keywords: " (current-region-or-word))
    (read-from-minibuffer "Extension: ")))
  (require 'browse-url)
  (browse-url-default-browser
   (concat "https://github.com/search?type=Code&q="
           keywords "+extension:" extension)))

(defun m|search-google (keywords)
  "Search with google."
  (interactive
   (list
    (read-from-minibuffer "Keywords: " (current-region-or-word))))
  (require 'browse-url)
  (browse-url-default-browser
   (concat "https://www.google.com/#q=" keywords)))
