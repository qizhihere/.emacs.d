(require 'evil)

(defmacro define-and-bind-text-object-by-regex (name key start-regex end-regex)
  "Define a simple text object by regex."
  (let ((inner-name (make-symbol (format "evil-inner-%s" name)))
        (outer-name (make-symbol (format "evil-a-%s" name))))
    `(progn
       (evil-define-text-object ,inner-name (count &optional beg end type)
         (evil-select-paren ,start-regex ,end-regex beg end type count nil))
       (evil-define-text-object ,outer-name (count &optional beg end type)
         (evil-select-paren ,start-regex ,end-regex beg end type count t))
       (define-key evil-inner-text-objects-map ,key (quote ,inner-name))
       (define-key evil-outer-text-objects-map ,key (quote ,outer-name)))))

;; simple regexp based text objects
(define-and-bind-text-object-by-regex "bar" "|" "|" "|")


;; function definition block
(evil-define-text-object evil-a-defun (count &optional beg end type)
  (list (save-excursion (beginning-of-defun) (point))
        (save-excursion (end-of-defun) (point))))
(define-key evil-outer-text-objects-map "f" #'evil-a-defun)
