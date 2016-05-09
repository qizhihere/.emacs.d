;; This file define some basic variables used by My Emacs.

(defconst m|cache-dir (concat user-emacs-directory ".cache")
  "The cache directory of myemacs. Temporary resources such as
session, auto saved files, and recently opened files will be put here.")

(defconst m|session-dir (concat user-emacs-directory ".session")
  "Session directory of myemacs. Desktop and session files will
  be put here.")

(defvar m|boot-silently nil "Disable verbose boot messages.")

(defvar m|console-color-theme 'spacemacs-dark
  "The theme applied when Emacs running in console mode.")

(defvar m|gui-color-theme 'spacegray
  "The theme applied when Emacs running in graphical mode.")

(defvar m|gui-font '("Source Code Pro" :size 12)
  "Font used in graphical mode.")

(defvar m|gui-chinese-font '("WenQuanYi Micro Hei Mono" :size 16)
  "Chinese font used in graphical mode.")

(defvar m|locale-environment "zh_CN.utf-8"
  "Emacs locale language which affects some modes such as org mode.")

(defvar m|whitespace-cleanup-style 'all
  "Tell `m|clean-whitespace' how to clean whitespace. `all' means
  clean all problematic whitespaces including empty lines,
  `trailing' means only clean trailing whitespaces.")

(defvar m|re-indent-on-newline t
  "Whether re-indent current text block when a new line is opened by RET.")

(defvar elpa-mirror-directory "~/.emacs.d/elpa-mirror")

(defvar m|use-elpa-mirror nil
  "When enabled, use elpa mirror in `elpa-mirror-directory'. And all other archive
repositories will be disabled.")


(provide 'core-vars)
