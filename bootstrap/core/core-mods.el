(require 'cl)
(require 'eieio)
(require 'subr-x)

(defvar m|mods (make-hash-table)
  "All available configuration modules.")

(defvar m|preload-mods '()
  "The modules which are loaded before others.")

(defvar m|enabled-mods '()
  "Enabled configuration modules.")

(defvar m|disabled-mods '()
  "Disabled configuration modules.")

(defvar m|loaded-mods '()
  "Loaded configuration modules.")

(defvar m|mod-policy 'allow
  "The module loading policy. Posibilities include: allow, deny.
If set to allow, `m|enabled-mods' is ignored, and only modules
not in `m|disabled-mods' can be loaded. If set to deny,
`m|disabled-mods' is ignored and only those in `m|enabled-mods'
can be loaded.")

(defvar m|pkgs '()
  "Required packages of all modules.")

(defvar m|mods-path (list (m|conf "mods"))
  "Mods directory path.")

(defconst m|mod-setup-file "setup.el"
  "The setup file name of mods.")

(defclass m|mod ()
  ((name :initarg :name
         :type symbol)
   (path :initarg :path
         :type string
         :initform "")
   (pkgs :initarg :pkgs
         :type list
         :initform ())
   (init-funcs :initarg :init-funcs
               :type list
               :initform ())
   (post-init-funcs :initarg :post-init-funcs
                    :type list
                    :initform ())
   (setup :initarg :setup
          :initform nil)
   (disabled :initarg :disabled
             :initform nil))
  "The base configuration module class.")

(defmethod m|setup-mod ((mo m|mod))
  "Setup a configuration module."
  (let* ((name (oref mo :name))
         (pkgs-var (intern (format "%s-packages" name)))
         (dir-var (intern (format "m|%s-conf-dir" name)))
         (file-var (intern (format "m|%s-setup-file" name))))
    (unless (oref mo :setup)
      ;; define module vars and constants
      (unless (boundp pkgs-var)
        (eval `(defvar ,pkgs-var '())))
      (unless (boundp dir-var)
        (eval `(defconst ,dir-var ,(oref mo :path))))
      (unless (boundp file-var)
        (eval `(defconst ,file-var ,(m|mod-setup-file mo))))
      (load (m|mod-setup-file mo) nil t)
      (oset mo :pkgs (symbol-value pkgs-var))
      (oset mo :setup t))))

(defmethod m|mod-setup-file ((mo m|mod))
  "Get the absolute setup file path of module."
  (let ((dir (oref mo :path)))
    (when dir
      (expand-file-name m|mod-setup-file dir))))

(defun m|mod-p (directory)
  "Test if a directory is a module. A valid module must contains
a `m|module-setup-file'."
  (and (file-directory-p directory)
       (file-exists-p (expand-file-name
                       m|mod-setup-file directory))))

(defun m|find-mods (directory)
  "Recursively find modules in given DIRECTORY."
  (let* ((directory (expand-file-name directory))
         (subdirs (remove-if-not #'file-directory-p
                                 (directory-files directory t "^[^.]")))
         mods)
    (when (m|mod-p directory)
      (push (m|mod :name (intern (file-name-nondirectory directory))
                   :path directory)
            mods))
    (dolist (subdir subdirs mods)
      (setq mods (append mods (m|find-mods subdir))))))

(defun m|init-mods ()
  "Initialize configuration mods."
  ;; find all modules and register them in `m|mods'
  (setq m|mods (make-hash-table))
  (dolist (path m|mods-path)
    (mapc
     (lambda (mo)
       (puthash (oref mo :name) mo m|mods))
     (m|find-mods path)))
  ;; collect info of modules
  (case m|mod-policy
    (allow
     (maphash
      (lambda (name mo)
        (if (memq name m|disabled-mods)
            (oset mo :disabled t)
          (m|setup-mod mo)
          (setq m|pkgs (union m|pkgs (oref mo :pkgs)))))
      m|mods))
    (deny
     (maphash
      (lambda (name mo)
        (if (memq name m|enabled-mods)
            (progn
              (m|setup-mod mo)
              (setq m|pkgs (union m|pkgs (oref mo :pkgs))))
          (oset mo :disabled t)))
      m|mods)))
  (let ((init-funcs (apropos-internal "/\\(post-\\)?init" #'fboundp)))
    (maphash
     (lambda (name mo)
       ;; find all init/post-init functions of module
       (unless (oref mo :disabled)
         (mapc (lambda (sym)
                 (when (fboundp sym)
                   (cond
                    ((string-prefix-p (format "%s/init-" name) (symbol-name sym))
                     (object-add-to-list mo :init-funcs sym t))
                    ((string-prefix-p (format "%s/post-init-" name) (symbol-name sym))
                     (object-add-to-list mo :post-init-funcs sym t)))))
               init-funcs)))
     m|mods)))

(defun m|load-mod (mod-name)
  "Load a configuration module if it hasn't been loaded yet."
  (let ((mod (gethash mod-name m|mods)))
    (or mod (error "Module %s not exist." mod-name))
    (when (oref mod :disabled)
      (message "Warning: module %s has been disabled." mod-name))
    (or (oref mod :setup) (m|setup-mod mod))
    (let* ((name (oref mod :name))
           (init-func (intern (format "%s/init" name)))
           (load-file-name (m|mod-setup-file mod)))
      (unless (memq name m|loaded-mods)
        ;; call module init function
        (when (fboundp init-func)
          (funcall init-func)
          ;; call module's other init functions
          (mapc #'funcall (oref mod :init-funcs))
          ;; add eval after loads for other packages
          (dolist (func (oref mod :post-init-funcs))
            (let ((pkg (intern (string-remove-prefix
                                (format "%s/post-init-" name)
                                (symbol-name func)))))
              (eval
               `(with-eval-after-load ',pkg
                  (funcall ',func)))))
          (push name m|loaded-mods))))))

(defun m|load-mods ()
  (unless m|mods (m|init-mods))
  (let* (mods len preload-mods)
    ;; get all enabled modules
    (maphash
     (lambda (name mo)
       (unless (oref mo :disabled)
         (push name mods)))
     m|mods)
    ;; get preload modules
    (dolist (name m|preload-mods)
      (let ((mo (gethash name m|mods)))
        (when (and mo (not (oref mo :disabled)))
          (setq preload-mods (append preload-mods `(,name))))))
    ;; move preload modules to the beginning of mods
    (setq mods (append preload-mods (set-difference mods preload-mods))
          len (length mods))
    ;; load rest mods
    (loop for name in mods
          for i from 1 do
          (unless (bound-and-true-p m|boot-silently)
            (message "Loading module(%s/%s): %s" i len name))
          (m|load-mod name))))



(provide 'core-mods)
