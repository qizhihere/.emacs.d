(defun pp-eval-expression (expression)
  "Evaluate EXPRESSION and pretty-print its value.
Also add the value to the front of the list in the variable `values'."
  (interactive
   (list (read--expression "Eval: ")))
  (setq values (cons (eval expression lexical-binding) values))
  (pp-display-expression (car values) "*Pp Eval Output*"))
