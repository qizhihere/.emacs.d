(require 'cl)
(require 'use-package)

(defun use-package-normalize/evil (pkg keyword args)
  (use-package-only-one (symbol-name keyword) args
    (lambda (label arg)
      (cond
       ((listp arg) arg)
       ((symbolp arg) (symbol-value arg))
       ((functionp arg) (funcall arg))
       (t
        (use-package-error
         ":%s wants a list of bindings. Given: %s" label arg))))))

(push :leader use-package-keywords)
(defalias 'use-package-normalize/:leader #'use-package-normalize/evil)
(defun use-package-handler/:leader (name keyword arg rest state)
  (unless (listp arg)
    (use-package-error
     ":leader wants a list of bindings, while %s given: %s"
     (type-of arg) arg))
  (let* (commands
         (alist (use-package--process-mixed-form arg))
         (sexps
          (loop for (k . bindings) in alist
                for mode = (plist-get k :mode)
                do
                (loop for i from 1 to (length bindings) by 2
                      for command = (nth i bindings)
                      do
                      (add-to-list 'commands command)
                      (setf (nth i bindings) `',command))
                collect
                (if mode
                    `(evil-leader/set-key-for-mode ',mode
                       ,@bindings)
                  `(evil-leader/set-key ,@bindings)))))
    (use-package-concat
     (use-package-process-keywords name
       (use-package-sort-keywords
        (use-package-plist-maybe-put rest :defer t))
       (use-package-plist-append state :commands commands))
     `((eval-after-load "evil-leader"
         '(progn ,@sexps))))))

(push :evil use-package-keywords)
(defvar use-package--evil-optional-keywords '(:defer))
(defalias 'use-package-normalize/:evil #'use-package-normalize/evil)
(defun use-package-handler/:evil (name keyword arg rest state)
  (let* (commands
         (alist (use-package--process-mixed-form arg))
         (sexps (list nil))
         (defer-sexps (make-hash-table)))
    (loop for (k . pairs) in alist
          for map = (or (plist-get k :map) 'global-map)
          for state = (or (plist-get k :state) 'normal)
          for defer = (or (plist-get k :defer) 'nil)
          do
          (let ((bindings (list nil))
                (maps (if (listp map) map
                        (list map)))
                (states (if (listp state) state
                          (list state))))
            (mapc
             (lambda (pair)
               (add-to-list 'commands (cdr pair))
               (nconc bindings `((kbd ,(car pair)) ',(cdr pair))))
             pairs)
            (let ((defer-1 (or (use-package--plist-get maps :defer) defer)))
              (dolist (m (use-package--trim-props maps))
                (let ((defer-2 (or (use-package--plist-get m :defer) defer-1)))
                  (dolist (s states)
                    (let ((form `(evil-define-key ',s ,m
                                   ,@(cdr bindings)))
                          (defer-3 (if (eq defer-2 t) name defer-2)))
                      (cond
                       ((eq defer-3 nil) (nconc sexps `(,form)))
                       ((symbolp defer-3) (use-package--append-hash defer-3 form defer-sexps))
                       (t (error "error type argument given: `:defer %s`" defer-3))))))))))
    (maphash
     (lambda (k v)
       (nconc sexps `((eval-after-load ,(symbol-name k)
                        '(progn ,@v)))))
     defer-sexps)
    (use-package-concat
     (use-package-process-keywords name
       (use-package-sort-keywords
        (use-package-plist-maybe-put rest :defer t))
       (use-package-plist-append state :commands commands))
     `((eval-after-load "evil"
         '(progn ,@(cdr sexps)))))))

(defun use-package--only-props (form)
  (cdr (use-package-split-list #'keywordp form)))

(defun use-package--trim-props (form)
  (car (use-package-split-list #'keywordp form)))

(defun use-package--append-hash (key elt table)
  (puthash key (append (gethash key table) (list elt)) table))

(defun use-package--plist-get (plist prop)
  (when (listp plist)
    (plist-get (use-package--only-props plist) prop)))

(defun use-package--process-mixed-form (form &optional default-key pred)
  (when form
    (if (use-package--front-plist-p form pred)
        (let ((segs (use-package--split-front-plist form pred)))
          (use-package--process-mixed-form (cdr segs) (car segs) pred))
      (let ((segs (use-package-split-list #'keywordp form)))
        `((,default-key . ,(car segs))
          ,@(use-package--process-mixed-form (cdr segs) pred))))))

(defun use-package--front-plist-p (form &optional pred)
  (let ((pred (or pred (lambda (k v) (keywordp k)))))
    (and (listp form)
         (>= (length form) 1)
         (not (memq (funcall pred (car form) (cadr form))
                    '(nil 0))))))

(defun use-package--split-front-plist (form &optional pred)
  (let ((pred (or pred (lambda (k v) (keywordp k))))
        (plist (list nil))
        (rest (list nil))
        (i 0) (len (length form))
        aborted)
    (unless (use-package--front-plist-p form pred)
      (error "No plist found at the front of form: %s" form))
    (while (< i len)
      (cl-flet ((give (x n)
                      (let ((n+i (+ n i)))
                        (unless (> n+i len)
                          (nconc x (subseq form i n+i)))
                        (setq i n+i))))
        (if aborted
            (give rest 1)
          (let* ((k (nth i form))
                 (v (nth (1+ i) form))
                 (ts (funcall pred k v)))
            (cond
             ((eq ts t) (give plist 2))
             ((numberp ts) (if (> ts 0) (give plist ts)
                             (setq aborted t)))
             ((memq ts '(nil 0)) (setq aborted t))
             (t (error "invalid return value from prediction: %s" ts)))))))
    (cons (cdr plist) (cdr rest))))



(provide 'core-use-package-ext)
