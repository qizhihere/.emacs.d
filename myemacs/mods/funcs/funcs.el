(defmacro execution-time (&rest code)
  "Get the execution time of `CODE'."
  `(let ((start (float-time)))
     (progn ,@code)
     (- (float-time) start)))

(defun concat-sym (&rest args)
  (intern (reduce #'concat (mapcar #'symbol-name args))))

(defmacro silently (&rest body)
  "Execute BODY silently."
  `(let ((inhibit-message t)
         message-log-max)
     ,@body))

(defmacro nolog (&rest body)
  "Execute BODY with message logging disabled."
  `(let (message-log-max)
     ,@body))

(defun current-region-or-word ()
  (interactive)
  (if (use-region-p)
      (let ((beg (region-beginning))
            (end (region-end)))
        (if (eq beg end)
            (current-word)
          (buffer-substring-no-properties beg end)))
    (current-word)))

(defun thing-at-point--region-advice (orig-func thing &optional no-properties)
  "Make `thing-at-point' support region thing. If no action
region then symbol is used."
  (if (eq thing 'region)
      (if (use-region-p)
          (if no-properties
              (buffer-substring-no-properties (region-beginning) (region-end))
            (buffer-substring (region-beginning) (region-end)))
        (funcall orig-func 'symbol no-properties))
    (funcall orig-func thing no-properties)))
(advice-add 'thing-at-point :around #'thing-at-point--region-advice)
