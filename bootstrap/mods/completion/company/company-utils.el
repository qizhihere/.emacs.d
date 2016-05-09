(require 'company)

(defun company/add-local-backend (backend &optional append)
  (make-local-variable 'company-backends)
  (add-to-list 'company-backends backend append))

(defun company/add-local-general-backend (backend)
  (make-local-variable 'company-backends)
  (loop for x in company-backends
        for i from 0
        for x = (if (listp x) x (list x))
        do
        (unless (memq backend x)
          (if (memq :with x)
              (nconc x `(,backend))
            (nconc x `(:with ,backend)))
          (setf (nth i company-backends) x))
        collect x))

(defun company/remove-local-general-backend (backend)
  (make-local-variable 'company-backends)
  (loop for x in company-backends
        for i from 0
        for x = (if (listp x) x (list x))
        for y = (memq :with x)
        do
        (when (memq backend y)
          (delq backend y)
          (when (= (length y) 1)
            (delq :with x))
          (when (= (length x) 1)
            (setq x (car x)))
          (setf (nth i company-backends) x))
        collect x))

(defun m|company-add-yasnippet-general-backend ()
  (company/add-local-general-backend 'company-yasnippet))
