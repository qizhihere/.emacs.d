;;; ob-php.el --- org-babel functions for php evaluation

;; Copyright (C) 2014 Josh Dukes

;; Author: Josh Dukes
;; Keywords: literate programming, reproducible research
;; Homepage: http://orgmode.org
;; Version: 0.01

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Org-Babel support for evaluating php source code.

;;; Requirements:

;; php and php-mode

;;; Code:
(require 'ob)

;; optionally define a file extension for this language
(add-to-list 'org-babel-tangle-lang-exts '("php" . "php"))

(defvar org-babel-php-command "php"
"Name of command for executing PHP code.")

;; This function expands the body of a source code block by doing
;; things like prepending argument definitions to the body, it is
;; be called by the `org-babel-execute:php' function below.
(defun org-babel-expand-body:php (body params &optional processed-params)
  "Expand BODY according to PARAMS, return the expanded body."
  (if (or (car (assoc :expand params)) nil)
      (let ((full-body
	     (org-babel-expand-body:generic
	      body
	      params
	      (org-babel-variable-assignments:php params))))
	(concat "<?php\n"
		full-body
		"\n?>"))
    (let ((vars
	   (concat "<?php\n"
		   (mapconcat
		    #'identity
		    (org-babel-variable-assignments:php params)
		    "\n")
		   "\n?>")))
      (concat vars body))))

(defun org-babel-prep-session:php (session params)
  "Prepare SESSION according to the header arguments in PARAMS."
  (error "Sessions are not supported for PHP"))

(defun org-babel-php-initiate-session (&optional session params)
  "Return nil because sessions are not supported by PHP."
  nil)

(defun org-babel-execute:php (body params)
  (let* ((session (cdr (assoc :session params)))
	 (flags (or (cdr (assoc :flags params)) ""))
	 (src-file (org-babel-temp-file "php-src-"))
	 (full-body (org-babel-expand-body:php body params))
	 (session (org-babel-php-initiate-session session))
	 (results
	  (progn
	    (with-temp-file src-file (insert full-body))
	    (org-babel-eval
	     (concat org-babel-php-command
		     " " flags " " src-file) ""))))
    (progn
      (org-babel-reassemble-table
       (org-babel-result-cond (cdr (assoc :result-params params))
	 (org-babel-read results)
         (let ((tmp-file (org-babel-temp-file "c-")))
           (with-temp-file tmp-file (insert results))
           (org-babel-import-elisp-from-file tmp-file)))
       (org-babel-pick-name
        (cdr (assoc :colname-names params)) (cdr (assoc :colnames params)))
       (org-babel-pick-name
        (cdr (assoc :rowname-names params)) (cdr (assoc :rownames params)))))))

(defun org-babel-variable-assignments:php (params)
  "Return a list of PHP statements assigning the block's variables."
  (mapcar
   (lambda (pair)
     (format "$%s=%s;"
	     (car pair)
	     (org-babel-php-var-to-php (cdr pair))))
   (mapcar #'cdr (org-babel-get-header params :var))))

(defun org-babel-php-var-to-php (var)
  "Convert an elisp var into a string of php source code
specifying a var of the same value."
  (if (listp var)
      (concat "Array(" (mapconcat #'org-babel-php-var-to-php var ",") ")")
  (format "%S" var)))

(defun org-babel-php-table-or-string (results)
  "If the results look like a table, then convert them into an
Emacs-lisp table, otherwise return the results as a string."
  (org-babel-script-escape results))

(provide 'ob-php)
;;; ob-php.el ends here
