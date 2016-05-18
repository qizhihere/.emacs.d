;;; spacegray-theme.el --- A Hyperminimal UI Theme

;; Copyright (C) 2013 Bruce Williams

;; Author: Bruce Williams <brwcodes@gmail.com>
;; Keywords: themes
;; Package-Version: 20131230.1127
;; URL: http://github.com/bruce/emacs-spacegray-theme
;; Version: 0.1
;; Package-Requires: ((emacs "24.1"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; To use it, put the following in your Emacs configuration file:
;;
;;   (load-theme 'spacegray t)
;;
;; Requirements: Emacs 24.

;;; Credits:

;; Gadzhi Kharkharov deserves most of the credit for color selection
;; as the author of the original Spacegray color theme for Sublime Text:
;; The MIT License (MIT) Copyright (c) 2013 Gadzhi Kharkharov
;; http://kkga.github.io/spacegray/

;; Also thanks to Ozan Sener for afternoon-theme, used as the boilerplate:
;; https://github.com/osener/emacs-afternoon-theme/
;; and Steve Purcell, who wrote color-theme-sanityinc-tomorrow:
;; https://github.com/purcell/color-theme-sanityinc-tomorrow/

;;; Code:

(deftheme spacegray
  "A Hyperminimal UI Theme for Emacs")
(display-color-cells (selected-frame))
(let* ((class '((class color) (min-colors 89)))
       (256color (eq (display-color-cells (selected-frame)) 256))

       (background "#2B303B") ;; sidebar-container
       (background+1 "#232830")
       (background-1 "#333D46")
       (background-2 "#343D46")
       (background-3 "#343843")
       (current-line "#323A42") ;; tree-row
       (far-background "#333D46") ;; panel-control
       (subtle "#A7ADBA") ;; tree-row-hover-disclosure-button-control
       (selection "#4F5B66") ;; tab-control-dirty-tab-close-button
       (secondary-selection "#1C1F26") ;; tab-control-hover-tab-close-button
       (foreground "#FFFFFF")
       (foreground-1 "#DEDEDE")
       (foreground-2 "#CDCDCD")
       (foreground-3 "#ABABAB")
       (foreground-4 "#8A8AAE")
       (foreground-5 "#65737E")
       (comment "#4F5B67") ;; table-row
       (red "#BF616A") ;; tab-control-hover-tab-close-button
       (orange "#DCA432") ;; darker tab-control-dirty-tab-close-butto
       (yellow "#EBCB8B") ;; tab-control-dirty-tab-close-button
       (green "#B4EB89") ;; complement tab-control-dirty-tab-close-button
       (aqua "#89EBCA") ;; lighter complement tab-control-dirty-tab-close-button
       (blue "#89AAEB") ;; complement tab-control-dirty-tab-close-button
       (blue-1 "#65A7E2")
       (purple "#C189EB")) ;; complement tab-control-dirty-tab-close-button

  (setq hl-sexp-background-color background-2
        pos-tip-foreground-color foreground-2
        pos-tip-background-color background+1)

  (setq evil-emacs-state-cursor '("pink" box)
        evil-normal-state-cursor '("orange" box)
        evil-visual-state-cursor '("green" box)
        evil-insert-state-cursor '("white" bar)
        evil-replace-state-cursor '("cyan" hbar)
        evil-operator-state-cursor '("red" hollow))

  (custom-theme-set-faces
   'spacegray
   `(default ((,class (:foreground ,foreground :background ,background))))
   `(bold ((,class (:weight bold))))
   `(bold-italic ((,class (:slant italic :weight bold))))
   `(underline ((,class (:underline t))))
   `(italic ((,class (:slant italic))))
   `(font-lock-builtin-face ((,class (:foreground "LightCoral"))))
   `(font-lock-comment-delimiter-face ((,class (:foreground ,comment))))
   `(font-lock-comment-face ((,class (:foreground ,comment :slant italic))))
   `(font-lock-constant-face ((,class (:foreground ,green))))
   `(font-lock-doc-face ((,class (:foreground "moccasin" :background ,background))))
   `(font-lock-doc-string-face ((,class (:foreground ,yellow :background ,background))))
   `(font-lock-function-name-face ((,class (:foreground ,orange))))
   `(font-lock-keyword-face ((,class (:foreground ,blue :weight semibold))))
   `(font-lock-negation-char-face ((,class (:foreground ,blue))))
   `(font-lock-preprocessor-face ((,class (:foreground "gold"))))
   `(font-lock-regexp-grouping-backslash ((,class (:foreground ,yellow))))
   `(font-lock-regexp-grouping-construct ((,class (:foreground ,purple))))
   `(font-lock-string-face ((,class (:foreground "burlywood" :background ,background))))
   `(font-lock-type-face ((,class (:foreground "CadetBlue1"))))
   `(font-lock-variable-name-face ((,class (:foreground ,yellow))))
   `(font-lock-warning-face ((,class (:weight bold :foreground ,red))))
   `(shadow ((,class (:foreground ,comment))))
   `(success ((,class (:foreground "SeaGreen2"))))
   `(error ((,class (:foreground ,red))))
   `(warning ((,class (:foreground ,orange))))

   ;; Flycheck
   `(flycheck-error ((,class (:underline (:style wave :color ,red)))))
   `(flycheck-warning ((,class (:underline (:style wave :color ,orange)))))

   ;; Flymake
   `(flymake-warnline ((,class (:underline (:style wave :color ,orange) :background ,background))))
   `(flymake-errline ((,class (:underline (:style wave :color ,red) :background ,background))))

   ;; company mode
   `(company-tooltip ((,class (:foreground ,foreground-5 :background ,background-1))))
   `(company-tooltip-annotation ((,class (:foreground ,foreground-5 :background ,background-1))))
   `(company-tooltip-selection ((,class (:foreground ,subtle :background ,selection))))
   `(company-tooltip-search ((,class (:weight bold))))
   `(company-tooltip-mouse ((,class (:background ,selection))))
   `(company-tooltip-common ((,class (:foreground ,foreground-2 :background ,background+1 :weight bold))))
   `(company-tooltip-common-selection ((,class (:background ,selection :weight bold))))
   `(company-template-field ((,class (:background ,selection))))
   `(company-scrollbar-fg ((,class (:background ,background-2))))
   `(company-scrollbar-bg ((,class (:background ,background+1))))
   `(company-preview ((,class ())))
   `(company-preview-common ((,class (:foreground ,foreground-3 :underline ,purple))))

   ;; enh ruby errors
   `(erm-syn-errline ((,class (:underline ,red))))
   `(erm-syn-warnline ((,class (:underline ,orange))))

   ;; Clojure errors
   `(clojure-test-failure-face ((,class (:background nil :inherit flymake-warnline))))
   `(clojure-test-error-face ((,class (:background nil :inherit flymake-errline))))
   `(clojure-test-success-face ((,class (:background nil :foreground nil :underline ,green))))

   ;; EDTS errors
   `(edts-face-warning-line ((,class (:background nil :inherit flymake-warnline))))
   `(edts-face-warning-mode-line ((,class (:background nil :foreground ,orange :weight bold))))
   `(edts-face-error-line ((,class (:background nil :inherit flymake-errline))))
   `(edts-face-error-mode-line ((,class (:background nil :foreground ,red :weight bold))))

   ;; For Brian Carper's extended clojure syntax table
   `(clojure-keyword ((,class (:foreground ,yellow))))
   `(clojure-parens ((,class (:foreground ,foreground))))
   `(clojure-braces ((,class (:foreground ,green))))
   `(clojure-brackets ((,class (:foreground ,yellow))))
   `(clojure-double-quote ((,class (:foreground ,aqua :background nil))))
   `(clojure-special ((,class (:foreground ,blue))))
   `(clojure-java-call ((,class (:foreground ,purple))))

   ;; ivy
   `(ivy-remote ((,class (:foreground ,foreground-5))))
   `(ivy-current-match ((,class (:background ,background+1 :foreground ,blue-1 :weight bold))))
   `(ivy-minibuffer-match-face-1 ((,class (:foreground ,foreground-4 :background nil))))
   `(ivy-minibuffer-match-face-2 ((,class (:background ,background-2 :foreground ,blue-1 :weight bold))))
   `(ivy-minibuffer-match-face-3 ((,class (:background ,background-2 :foreground "dodger blue" :weight bold))))
   `(ivy-minibuffer-match-face-4 ((,class (:background ,background-2 :foreground "pink" :weight bold))))

   ;; Rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((,class (:foreground ,foreground))))
   `(rainbow-delimiters-depth-2-face ((,class (:foreground ,aqua))))
   `(rainbow-delimiters-depth-3-face ((,class (:foreground ,yellow))))
   `(rainbow-delimiters-depth-4-face ((,class (:foreground ,green))))
   `(rainbow-delimiters-depth-5-face ((,class (:foreground ,blue))))
   `(rainbow-delimiters-depth-6-face ((,class (:foreground ,foreground))))
   `(rainbow-delimiters-depth-7-face ((,class (:foreground ,aqua))))
   `(rainbow-delimiters-depth-8-face ((,class (:foreground ,yellow))))
   `(rainbow-delimiters-depth-9-face ((,class (:foreground ,green))))
   `(rainbow-delimiters-unmatched-face ((,class (:foreground ,red))))

   ;; MMM-mode
   `(mmm-code-submode-face ((,class (:background ,current-line))))
   `(mmm-comment-submode-face ((,class (:inherit font-lock-comment-face))))
   `(mmm-output-submode-face ((,class (:background ,current-line))))

   ;; bm
   `(bm-persistent-face ((,class (:background ,current-line))))
   `(bm-face ((,class (:background ,current-line))))

   ;; Search
   `(match ((,class (:foreground "white"  :background ,secondary-selection))))
   `(isearch ((,class (:foreground "black" :background "moccasin"))))
   `(isearch-lazy-highlight-face ((,class (:foreground "white" :background "#6F6F6F"))))
   `(isearch-fail ((,class (:foreground "white" :background "magenta" :weight bold))))

   ;; Anzu
   `(anzu-mode-line ((,class (:foreground ,orange))))
   `(anzu-replace-highlight ((,class (:inherit isearch-lazy-highlight-face))))
   `(anzu-replace-to ((,class (:inherit isearch))))

   ;; IDO
   `(ido-subdir ((,class (:foreground ,purple))))
   `(ido-first-match ((,class (:foreground ,orange))))
   `(ido-only-match ((,class (:foreground ,selection))))
   `(ido-indicator ((,class (:foreground ,red :background ,background))))
   `(ido-virtual ((,class (:foreground ,comment))))

   ;; flx-ido
   `(flx-highlight-face ((,class (:inherit nil :foreground ,yellow :weight bold :underline nil))))

   ;; which-function
   `(which-func ((,class (:foreground ,blue :background nil))))

   ;; Emacs interface
   `(cursor ((,class (:background "moccasin"))))
   `(fringe ((,class (:background ,background))))
   `(linum ((,class (:background ,background :foreground ,selection :weight semi-bold))))
   `(linum-highlight-face ((,class (:background ,current-line :foreground ,foreground))))
   `(linum-relative-current-face ((,class (:background ,background-2 :inherit linum :foreground "#CAE682" :weight bold))))
   `(border ((,class (:background ,current-line))))
   `(border-glyph ((,class (nil))))
   `(highlight ((,class (:inverse-video nil :background ,current-line))))
   `(gui-element ((,class (:background ,current-line :foreground ,foreground))))
   `(mode-line ((,class (:foreground ,foreground-4 :background "#2D333D"
                         :family "Source Code Pro"))))
   `(mode-line-buffer-id ((,class (:foreground ,purple :background nil :weight semibold))))
   `(mode-line-inactive ((,class (:inherit mode-line
                                  :foreground ,subtle
                                  :background ,background :weight normal
                                  :box nil))))
   `(mode-line-emphasis ((,class (:foreground ,foreground-2 :slant italic))))
   `(mode-line-highlight ((,class (:foreground ,purple :box nil))))
   `(minibuffer-prompt ((,class (:foreground ,blue))))
   `(region ((,class (:background ,selection))))
   `(secondary-selection ((,class (:background ,secondary-selection))))

   `(header-line ((,class (:inherit mode-line :foreground ,purple :background nil))))
   `(hs-face ((,class (:background nil))))
   `(vertical-border ((,class (:foreground ,selection))))


   `(trailing-whitespace ((,class (:background "magenta" :inverse-video nil :underline nil))))
   `(hc-trailing-whitespace ((,class (:background "magenta" :inverse-video nil :underline nil))))
   `(whitespace-trailing ((,class (:background "magenta" :inverse-video nil :underline nil))))
   `(whitespace-space-after-tab ((,class (:background "magenta" :inverse-video nil :underline nil))))
   `(whitespace-space-before-tab ((,class (:background "magenta" :inverse-video nil :underline nil))))
   `(whitespace-empty ((,class (:background "magenta" :inverse-video nil :underline nil))))
   `(whitespace-line ((,class (:background nil :foreground "magenta"))))
   `(whitespace-indentation ((,class (:background nil :foreground ,aqua))))
   `(whitespace-space ((,class (:background nil :foreground ,selection))))
   `(whitespace-newline ((,class (:background nil :foreground ,selection))))
   `(whitespace-tab ((,class (:background nil :foreground ,selection))))
   `(whitespace-hspace ((,class (:background nil :foreground ,selection))))

   ;; Parenthesis matching (built-in)
   `(show-paren-match ((,class (:background "#4F5B66" :underline t :weight bold))))
   `(show-paren-mismatch ((,class (:background "red1" :weight bold))))

   ;; Smartparens paren matching
   `(sp-show-pair-match-face ((,class (:foreground nil :background nil :inherit show-paren-match))))
   `(sp-show-pair-mismatch-face ((,class (:foreground nil :background nil :inherit show-paren-mismatch))))

   ;; Parenthesis matching (mic-paren)
   `(paren-face-match ((,class (:foreground nil :background nil :inherit show-paren-match))))
   `(paren-face-mismatch ((,class (:foreground nil :background nil :inherit show-paren-mismatch))))
   `(paren-face-no-match ((,class (:foreground nil :background nil :inherit show-paren-mismatch))))

   ;; Parenthesis dimming (parenface)
   `(paren-face ((,class (:foreground ,comment :background nil))))

   `(sh-heredoc ((,class (:foreground nil :inherit font-lock-string-face :weight normal))))
   `(sh-quoted-exec ((,class (:foreground nil :inherit font-lock-preprocessor-face))))
   `(slime-highlight-edits-face ((,class (:weight bold))))
   `(slime-repl-input-face ((,class (:weight normal :underline nil))))
   `(slime-repl-prompt-face ((,class (:underline nil :weight bold :foreground ,purple))))
   `(slime-repl-result-face ((,class (:foreground ,green))))
   `(slime-repl-output-face ((,class (:foreground ,blue :background ,background))))

   `(csv-separator-face ((,class (:foreground ,orange))))

   `(diff-added ((,class (:foreground ,green))))
   `(diff-changed ((,class (:foreground ,purple))))
   `(diff-removed ((,class (:foreground ,orange))))
   `(diff-header ((,class (:foreground ,aqua :background nil))))
   `(diff-file-header ((,class (:foreground ,blue :background nil))))
   `(diff-hunk-header ((,class (:foreground ,purple))))
   `(diff-refine-added ((,class (:inherit diff-added :inverse-video t))))
   `(diff-refine-removed ((,class (:inherit diff-removed :inverse-video t))))

   `(ediff-even-diff-A ((,class (:foreground nil :background nil :inverse-video t))))
   `(ediff-even-diff-B ((,class (:foreground nil :background nil :inverse-video t))))
   `(ediff-odd-diff-A  ((,class (:foreground ,comment :background nil :inverse-video t))))
   `(ediff-odd-diff-B  ((,class (:foreground ,comment :background nil :inverse-video t))))

   `(eldoc-highlight-function-argument ((,class (:foreground ,green :weight bold))))

   ;; macrostep
   `(macrostep-expansion-highlight-face ((,class (:inherit highlight :foreground nil))))

   ;; undo-tree
   `(undo-tree-visualizer-default-face ((,class (:foreground ,foreground))))
   `(undo-tree-visualizer-current-face ((,class (:foreground ,green :weight bold))))
   `(undo-tree-visualizer-active-branch-face ((,class (:foreground ,red))))
   `(undo-tree-visualizer-register-face ((,class (:foreground ,yellow))))

   ;; dired+
   `(diredp-compressed-file-suffix ((,class (:foreground ,blue))))
   `(diredp-deletion ((,class (:inherit error :inverse-video t))))
   `(diredp-deletion-file-name ((,class (:inherit error))))
   `(diredp-dir-heading ((,class (:foreground ,green :weight bold))))
   `(diredp-dir-priv ((,class (:foreground ,aqua :background nil))))
   `(diredp-exec-priv ((,class (:foreground ,blue :background nil))))
   `(diredp-executable-tag ((,class (:foreground ,red :background nil))))
   `(diredp-dir-name ((,class (:foreground ,blue :background nil :weight semi-bold))))
   `(diredp-file-name ((,class (:foreground ,yellow))))
   `(diredp-file-suffix ((,class (:foreground ,green))))
   `(diredp-flag-mark ((,class (:foreground ,green :inverse-video t))))
   `(diredp-flag-mark-line ((,class (:background nil :inherit highlight))))
   `(diredp-ignored-file-name ((,class (:foreground ,comment))))
   `(diredp-link-priv ((,class (:background nil :foreground ,purple))))
   `(diredp-mode-line-flagged ((,class (:foreground ,red))))
   `(diredp-mode-line-marked ((,class (:foreground ,green))))
   `(diredp-no-priv ((,class (:background nil))))
   `(diredp-number ((,class (:foreground ,yellow))))
   `(diredp-other-priv ((,class (:background nil :foreground ,purple))))
   `(diredp-rare-priv ((,class (:foreground ,red :background nil))))
   `(diredp-read-priv ((,class (:foreground ,green :background nil))))
   `(diredp-symlink ((,class (:foreground ,purple))))
   `(diredp-write-priv ((,class (:foreground ,yellow :background nil))))

   ;; smart mode line
   `(sml/col-number ((,class (:inherit sml/global))))
   `(sml/filename ((,class (:inherit mode-line-buffer-id :weight normal))))
   `(sml/global ((,class (:inherit font-lock-preprocessor-face :foreground "#438BFD"))))
   `(sml/line-number ((,class (:inherit sml/modes))))
   `(sml/modified ((,class (:inherit sml/not-modified :foreground "Red" :weight bold))))
   `(sml/not-modified ((,class (:inherit sml/col-number))))

   ;; window numbering color
   `(window-numbering-face ((,class (:foreground ,foreground-4 :weight semi-bold))))

   ;; edbi
   `(ctbl:face-cell-select ((,class (:background ,background-1))))
   `(ctbl:face-row-select ((,class (:background ,background-1))))

   ;; Magit (a patch is pending in magit to make these standard upstream)
   `(magit-branch ((,class (:foreground ,green))))
   `(magit-diff-add ((,class (:inherit diff-added))))
   `(magit-diff-del ((,class (:inherit diff-removed))))
   `(magit-diff-file-heading ((,class (:weight normal))))
   `(magit-diff-context-highlight ((,class (:weight normal :background ,background-2))))
   `(magit-diff-hunk-heading ((,class (:weight normal :foreground ,foreground :background ,background-1))))
   `(magit-diff-hunk-heading-highlight ((,class (:weight normal :foreground ,yellow :background ,background-2))))
   `(magit-header ((,class (:inherit nil :weight bold))))
   `(magit-item-highlight ((,class (:inherit highlight :background nil))))
   `(magit-log-author ((,class (:foreground ,aqua))))
   `(magit-log-graph ((,class (:foreground ,comment))))
   `(magit-log-head-label-bisect-bad ((,class (:foreground ,red))))
   `(magit-log-head-label-bisect-good ((,class (:foreground ,green))))
   `(magit-log-head-label-default ((,class (:foreground ,yellow :box nil :weight bold))))
   `(magit-log-head-label-local ((,class (:foreground ,purple :box nil :weight bold))))
   `(magit-log-head-label-remote ((,class (:foreground ,purple :box nil :weight bold))))
   `(magit-log-head-label-tags ((,class (:foreground ,aqua :box nil :weight bold))))
   `(magit-log-sha1 ((,class (:foreground ,yellow))))
   `(magit-section-title ((,class (:foreground ,blue :weight bold))))
   `(magit-section-highlight ((,class (:background ,background-2))))

   ;; git-gutter
   `(git-gutter:added ((,class (:foreground "green" :background ,background  :weight bold))))
   `(git-gutter:deleted ((,class  (:foreground "red" :background ,background  :weight bold))))
   `(git-gutter:modified ((,class  (:foreground ,purple :background ,background :weight bold))))
   `(git-gutter:unchanged ((,class (:background ,background :weight bold))))

   ;; git-gutter+
   `(git-gutter+-added ((,class (:foreground "green" :background ,background  :weight bold))))
   `(git-gutter+-deleted ((,class  (:foreground "red" :background ,background  :weight bold))))
   `(git-gutter+-modified ((,class  (:foreground ,purple :background ,background :weight bold))))
   `(git-gutter+-unchanged ((,class (:background ,background :weight bold))))

   ;; git-gutter-fringe
   `(git-gutter-fr:modified ((,class (:foreground ,purple :weight bold))))
   `(git-gutter-fr:added ((,class (:foreground ,green :weight bold))))
   `(git-gutter-fr:deleted ((,class (:foreground ,red :weight bold))))

   `(link ((,class (:foreground ,green :underline t))))
   `(custom-button ((,class (:underline t :box (:line-width 1 :color ,comment)))))
   `(custom-field ((,class (:underline nil :box nil))))
   `(widget-button ((,class (:underline t :box (:line-width 1 :color ,comment)))))
   `(widget-field ((,class (:background ,background-2 :box (:line-width 1 :color ,comment)))))

   ;; Compilation (most faces politely inherit from 'success, 'error, 'warning etc.)
   `(compilation-column-number ((,class (:foreground ,yellow))))
   `(compilation-line-number ((,class (:foreground ,yellow))))
   `(compilation-message-face ((,class (:foreground ,blue))))
   `(compilation-mode-line-exit ((,class (:foreground ,green))))
   `(compilation-mode-line-fail ((,class (:foreground ,red))))
   `(compilation-mode-line-run ((,class (:foreground ,blue))))

   ;; helm
   `(helm-selection-line ((,class (:foreground ,foreground :background ,subtle))))
   `(helm-ff-directory ((,class (:foreground ,blue :background ,background))))
   `(helm-candidate-number ((,class (:background ,far-background :foreground ,green))))
   `(helm-header ((,class (:inherit header-line :background ,background))))
   `(helm-match ((,class (:background ,background-2 :foreground ,foreground :weight bold))))
   `(helm-selection ((,class (:background ,background-2 :distant-foreground "black"))))
   `(helm-source-header ((,class (:background ,background-3 :foreground ,foreground :weight semi-bold))))
   `(helm-visible-mark ((,class (:background ,background+1 :foreground "#DCA432"))))

   ;; Man page colors
   `(Man-overstrike ((,class (:inherit bold :foreground "#FF5F00"))))
   `(Man-reverse ((,class (:inherit highlight :background "#00AFD7" :foreground "color-231"))))
   `(Man-underline ((,class (:inherit underline :foreground "#00D75F"))))

   ;; Grep
   `(grep-context-face ((,class (:foreground ,comment))))
   `(grep-error-face ((,class (:foreground ,red :weight bold :underline t))))
   `(grep-hit-face ((,class (:foreground ,blue))))
   `(grep-match-face ((,class (:foreground nil :background nil :inherit match))))

   `(regex-tool-matched-face ((,class (:foreground nil :background nil :inherit match))))

   ;; mark-multiple
   `(mm/master-face ((,class (:inherit region :background nil))))
   `(mm/mirror-face ((,class (:inherit region :background nil))))

   ;; org mode
   `(org-agenda-structure ((,class (:foreground ,purple))))
   `(org-agenda-date ((,class (:foreground ,blue :underline nil))))
   `(org-agenda-done ((,class (:foreground ,green))))
   `(org-agenda-dimmed-todo-face ((,class (:foreground ,comment))))
   `(org-block ((,class (:foreground ,orange))))
   `(org-block-background ((,class (:background ,background))))
   `(org-code ((,class (:foreground ,yellow))))
   `(org-column ((,class (:background ,current-line))))
   `(org-column-title ((,class (:inherit org-column :weight bold :underline t))))
   `(org-date ((,class (:foreground ,blue :underline t))))
   `(org-document-info ((,class (:foreground ,aqua))))
   `(org-document-info-keyword ((,class (:foreground ,green))))
   `(org-document-title ((,class (:foreground ,orange :height 1.1))))
   `(org-done ((,class (:foreground ,green))))
   `(org-ellipsis ((,class (:foreground ,comment))))
   `(org-footnote ((,class (:foreground ,aqua))))
   `(org-formula ((,class (:foreground ,red))))
   `(org-hide ((,class (:foreground ,background :background ,background))))
   `(org-link ((,class (:foreground ,blue :underline t))))
   `(org-scheduled ((,class (:foreground ,green))))
   `(org-scheduled-previously ((,class (:foreground ,orange))))
   `(org-scheduled-today ((,class (:foreground ,green))))
   `(org-special-keyword ((,class (:foreground ,orange))))
   `(org-table ((,class (:foreground ,purple))))
   `(org-todo ((,class (:foreground ,red))))
   `(org-upcoming-deadline ((,class (:foreground ,orange))))
   `(org-warning ((,class (:weight bold :foreground ,red))))

   `(Info-quoted ((,class (:foreground "gray" :slant italic :family "Source Code Pro"))))

   `(markdown-url-face ((,class (:inherit link))))
   `(markdown-link-face ((,class (:foreground ,blue :underline t))))

   `(hl-sexp-face ((,class (:background ,background-2))))
   `(highlight-symbol-face ((,class (:background ,background-2))))
   `(highlight-thing ((,class (:background ,background-2))))
   `(highlight-80+ ((,class (:background ,current-line))))

   ;; Python-specific overrides
   `(py-builtins-face ((,class (:foreground ,orange :weight normal))))

   ;; js2-mode
   `(js2-warning ((,class (:underline ,orange))))
   `(js2-error ((,class (:foreground nil :underline ,red))))
   `(js2-external-variable ((,class (:foreground ,purple))))
   `(js2-function-param ((,class (:foreground ,blue))))
   `(js2-instance-member ((,class (:foreground ,blue))))
   `(js2-private-function-call ((,class (:foreground ,red))))

   ;; js3-mode
   `(js3-warning-face ((,class (:underline ,orange))))
   `(js3-error-face ((,class (:foreground nil :underline ,red))))
   `(js3-external-variable-face ((,class (:foreground ,purple))))
   `(js3-function-param-face ((,class (:foreground ,blue))))
   `(js3-jsdoc-tag-face ((,class (:foreground ,orange))))
   `(js3-jsdoc-type-face ((,class (:foreground ,aqua))))
   `(js3-jsdoc-value-face ((,class (:foreground ,yellow))))
   `(js3-jsdoc-html-tag-name-face ((,class (:foreground ,blue))))
   `(js3-jsdoc-html-tag-delimiter-face ((,class (:foreground ,green))))
   `(js3-instance-member-face ((,class (:foreground ,blue))))
   `(js3-private-function-call-face ((,class (:foreground ,red))))

   ;; web-mode
   `(web-mode-current-column-highlight-face ((,class (:background ,background+1))))

   ;; coffee-mode
   `(coffee-mode-class-name ((,class (:foreground ,orange :weight bold))))
   `(coffee-mode-function-param ((,class (:foreground ,purple))))

   ;; nxml
   `(nxml-name-face ((,class (:foreground unspecified :inherit font-lock-constant-face))))
   `(nxml-attribute-local-name-face ((,class (:foreground unspecified :inherit font-lock-variable-name-face))))
   `(nxml-ref-face ((,class (:foreground unspecified :inherit font-lock-preprocessor-face))))
   `(nxml-delimiter-face ((,class (:foreground unspecified :inherit font-lock-keyword-face))))
   `(nxml-delimited-data-face ((,class (:foreground unspecified :inherit font-lock-string-face))))
   `(rng-error-face ((,class (:underline ,red))))

   ;; RHTML
   `(erb-delim-face ((,class (:background ,current-line))))
   `(erb-exec-face ((,class (:background ,current-line :weight bold))))
   `(erb-exec-delim-face ((,class (:background ,current-line))))
   `(erb-out-face ((,class (:background ,current-line :weight bold))))
   `(erb-out-delim-face ((,class (:background ,current-line))))
   `(erb-comment-face ((,class (:background ,current-line :weight bold :slant italic))))
   `(erb-comment-delim-face ((,class (:background ,current-line))))

   ;; Message-mode
   `(message-header-other ((,class (:foreground nil :background nil :weight normal))))
   `(message-header-subject ((,class (:inherit message-header-other :weight bold :foreground ,yellow))))
   `(message-header-to ((,class (:inherit message-header-other :weight bold :foreground ,orange))))
   `(message-header-cc ((,class (:inherit message-header-to :foreground nil))))
   `(message-header-name ((,class (:foreground ,blue :background nil))))
   `(message-header-newsgroups ((,class (:foreground ,aqua :background nil :slant normal))))
   `(message-separator ((,class (:foreground ,purple))))

   ;; Jabber
   `(jabber-chat-prompt-local ((,class (:foreground ,yellow))))
   `(jabber-chat-prompt-foreign ((,class (:foreground ,orange))))
   `(jabber-chat-prompt-system ((,class (:foreground ,yellow :weight bold))))
   `(jabber-chat-text-local ((,class (:foreground ,yellow))))
   `(jabber-chat-text-foreign ((,class (:foreground ,orange))))
   `(jabber-chat-text-error ((,class (:foreground ,red))))

   `(jabber-roster-user-online ((,class (:foreground ,green))))
   `(jabber-roster-user-xa ((,class :foreground ,comment)))
   `(jabber-roster-user-dnd ((,class :foreground ,yellow)))
   `(jabber-roster-user-away ((,class (:foreground ,orange))))
   `(jabber-roster-user-chatty ((,class (:foreground ,purple))))
   `(jabber-roster-user-error ((,class (:foreground ,red))))
   `(jabber-roster-user-offline ((,class (:foreground ,comment))))

   `(jabber-rare-time-face ((,class (:foreground ,comment))))
   `(jabber-activity-face ((,class (:foreground ,purple))))
   `(jabber-activity-personal-face ((,class (:foreground ,aqua))))

   ;; popup
   `(popup-tip-face ((,class (:background ,background+1 :foreground ,foreground))))
   `(popup-face ((,class (:background ,background-1 :foreground ,foreground-5))))
   `(popup-menu-selection-face ((,class (:background ,selection :foreground ,foreground-2))))
   `(popup-isearch-match ((,class (:background ,selection))))
   `(popup-menu-mouse-face ((,class (:inherit popup-menu-selection-face))))
   `(popup-scroll-bar-foreground-face ((,class (:background ,background-2))))
   `(popup-scroll-bar-background-face ((,class (:background ,background+1))))

   ;; Powerline
   `(powerline-active1 ((,class (:foreground ,foreground :background ,selection))))
   `(powerline-active2 ((,class (:foreground ,foreground :background ,current-line))))

   ;; Outline
   `(outline-1 ((,class (:inherit nil :foreground "SkyBlue1"))))
   `(outline-2 ((,class (:inherit nil :foreground ,yellow))))
   `(outline-3 ((,class (:inherit nil :foreground ,purple))))
   `(outline-4 ((,class (:inherit nil :foreground ,aqua))))
   `(outline-5 ((,class (:inherit nil :foreground ,orange))))
   `(outline-6 ((,class (:inherit nil :foreground "CadetBlue1"))))
   `(outline-7 ((,class (:inherit nil :foreground "aquamarine1"))))
   `(outline-8 ((,class (:inherit nil :foreground "turquoise2"))))
   `(outline-9 ((,class (:inherit nil :foreground "LightSteelBlue1"))))

   ;; Ledger-mode
   `(ledger-font-comment-face ((,class (:inherit font-lock-comment-face))))
   `(ledger-font-occur-narrowed-face ((,class (:inherit font-lock-comment-face :invisible t))))
   `(ledger-font-occur-xact-face ((,class (:inherit highlight))))
   `(ledger-font-payee-cleared-face ((,class (:foreground ,green))))
   `(ledger-font-payee-uncleared-face ((,class (:foreground ,aqua))))
   `(ledger-font-posting-account-cleared-face ((,class (:foreground ,blue))))
   `(ledger-font-posting-account-face ((,class (:foreground ,purple))))
   `(ledger-font-posting-account-pending-face ((,class (:foreground ,yellow))))
   `(ledger-font-xact-highlight-face ((,class (:inherit highlight))))
   `(ledger-occur-narrowed-face ((,class (:inherit font-lock-comment-face :invisible t))))
   `(ledger-occur-xact-face ((,class (:inherit highlight))))

   ;; mu4e
   `(mu4e-header-highlight-face ((,class (:underline nil :inherit region))))
   `(mu4e-header-marks-face ((,class (:underline nil :foreground ,yellow))))
   `(mu4e-flagged-face ((,class (:foreground ,orange :inherit nil))))
   `(mu4e-replied-face ((,class (:foreground ,blue :inherit nil))))
   `(mu4e-unread-face ((,class (:foreground ,yellow :inherit nil))))
   `(mu4e-cited-1-face ((,class (:inherit outline-1 :slant normal))))
   `(mu4e-cited-2-face ((,class (:inherit outline-2 :slant normal))))
   `(mu4e-cited-3-face ((,class (:inherit outline-3 :slant normal))))
   `(mu4e-cited-4-face ((,class (:inherit outline-4 :slant normal))))
   `(mu4e-cited-5-face ((,class (:inherit outline-5 :slant normal))))
   `(mu4e-cited-6-face ((,class (:inherit outline-6 :slant normal))))
   `(mu4e-cited-7-face ((,class (:inherit outline-7 :slant normal))))
   `(mu4e-ok-face ((,class (:foreground ,green))))
   `(mu4e-view-contact-face ((,class (:inherit nil :foreground ,yellow))))
   `(mu4e-view-link-face ((,class (:inherit link :foreground ,blue))))
   `(mu4e-view-url-number-face ((,class (:inherit nil :foreground ,aqua))))
   `(mu4e-view-attach-number-face ((,class (:inherit nil :foreground ,orange))))
   `(mu4e-highlight-face ((,class (:inherit highlight))))
   `(mu4e-title-face ((,class (:inherit nil :foreground ,green))))

   ;; Gnus
   `(gnus-cite-1 ((,class (:inherit outline-1 :foreground nil))))
   `(gnus-cite-2 ((,class (:inherit outline-2 :foreground nil))))
   `(gnus-cite-3 ((,class (:inherit outline-3 :foreground nil))))
   `(gnus-cite-4 ((,class (:inherit outline-4 :foreground nil))))
   `(gnus-cite-5 ((,class (:inherit outline-5 :foreground nil))))
   `(gnus-cite-6 ((,class (:inherit outline-6 :foreground nil))))
   `(gnus-cite-7 ((,class (:inherit outline-7 :foreground nil))))
   `(gnus-cite-8 ((,class (:inherit outline-8 :foreground nil))))
   ;; there are several more -cite- faces...
   `(gnus-header-content ((,class (:inherit message-header-other))))
   `(gnus-header-subject ((,class (:inherit message-header-subject))))
   `(gnus-header-from ((,class (:inherit message-header-other-face :weight bold :foreground ,orange))))
   `(gnus-header-name ((,class (:inherit message-header-name))))
   `(gnus-button ((,class (:inherit link :foreground nil))))
   `(gnus-signature ((,class (:inherit font-lock-comment-face))))

   `(gnus-summary-normal-unread ((,class (:foreground ,blue :weight normal))))
   `(gnus-summary-normal-read ((,class (:foreground ,foreground :weight normal))))
   `(gnus-summary-normal-ancient ((,class (:foreground ,aqua :weight normal))))
   `(gnus-summary-normal-ticked ((,class (:foreground ,orange :weight normal))))
   `(gnus-summary-low-unread ((,class (:foreground ,comment :weight normal))))
   `(gnus-summary-low-read ((,class (:foreground ,comment :weight normal))))
   `(gnus-summary-low-ancient ((,class (:foreground ,comment :weight normal))))
   `(gnus-summary-high-unread ((,class (:foreground ,yellow :weight normal))))
   `(gnus-summary-high-read ((,class (:foreground ,green :weight normal))))
   `(gnus-summary-high-ancient ((,class (:foreground ,green :weight normal))))
   `(gnus-summary-high-ticked ((,class (:foreground ,orange :weight normal))))
   `(gnus-summary-cancelled ((,class (:foreground ,red :background nil :weight normal))))

   `(gnus-group-mail-low ((,class (:foreground ,comment))))
   `(gnus-group-mail-low-empty ((,class (:foreground ,comment))))
   `(gnus-group-mail-1 ((,class (:foreground nil :weight normal :inherit outline-1))))
   `(gnus-group-mail-2 ((,class (:foreground nil :weight normal :inherit outline-2))))
   `(gnus-group-mail-3 ((,class (:foreground nil :weight normal :inherit outline-3))))
   `(gnus-group-mail-4 ((,class (:foreground nil :weight normal :inherit outline-4))))
   `(gnus-group-mail-5 ((,class (:foreground nil :weight normal :inherit outline-5))))
   `(gnus-group-mail-6 ((,class (:foreground nil :weight normal :inherit outline-6))))
   `(gnus-group-mail-1-empty ((,class (:inherit gnus-group-mail-1 :foreground ,comment))))
   `(gnus-group-mail-2-empty ((,class (:inherit gnus-group-mail-2 :foreground ,comment))))
   `(gnus-group-mail-3-empty ((,class (:inherit gnus-group-mail-3 :foreground ,comment))))
   `(gnus-group-mail-4-empty ((,class (:inherit gnus-group-mail-4 :foreground ,comment))))
   `(gnus-group-mail-5-empty ((,class (:inherit gnus-group-mail-5 :foreground ,comment))))
   `(gnus-group-mail-6-empty ((,class (:inherit gnus-group-mail-6 :foreground ,comment))))
   `(gnus-group-news-1 ((,class (:foreground nil :weight normal :inherit outline-5))))
   `(gnus-group-news-2 ((,class (:foreground nil :weight normal :inherit outline-6))))
   `(gnus-group-news-3 ((,class (:foreground nil :weight normal :inherit outline-7))))
   `(gnus-group-news-4 ((,class (:foreground nil :weight normal :inherit outline-8))))
   `(gnus-group-news-5 ((,class (:foreground nil :weight normal :inherit outline-1))))
   `(gnus-group-news-6 ((,class (:foreground nil :weight normal :inherit outline-2))))
   `(gnus-group-news-1-empty ((,class (:inherit gnus-group-news-1 :foreground ,comment))))
   `(gnus-group-news-2-empty ((,class (:inherit gnus-group-news-2 :foreground ,comment))))
   `(gnus-group-news-3-empty ((,class (:inherit gnus-group-news-3 :foreground ,comment))))
   `(gnus-group-news-4-empty ((,class (:inherit gnus-group-news-4 :foreground ,comment))))
   `(gnus-group-news-5-empty ((,class (:inherit gnus-group-news-5 :foreground ,comment))))
   `(gnus-group-news-6-empty ((,class (:inherit gnus-group-news-6 :foreground ,comment))))

   ;; emms
   `(emms-playlist-selected-face ((,class (:foreground ,orange))))
   `(emms-playlist-track-face ((,class (:foreground ,blue))))
   `(emms-browser-track-face ((,class (:foreground ,blue))))
   `(emms-browser-artist-face ((,class (:foreground ,red :height 1.3))))
   `(emms-browser-composer-face ((,class (:inherit emms-browser-artist-face))))
   `(emms-browser-performer-face ((,class (:inherit emms-browser-artist-face))))
   `(emms-browser-album-face ((,class (:foreground ,green :height 1.2))))

   ;; stripe-buffer
   `(stripe-highlight ((,class (:background ,current-line))))
   `(stripe-hl-line ((,class (:background ,selection :foreground ,foreground))))

   ;; erc
   `(erc-direct-msg-face ((,class (:foreground ,orange))))
   `(erc-error-face ((,class (:foreground ,red))))
   `(erc-header-face ((,class (:foreground ,foreground :background ,selection))))
   `(erc-input-face ((,class (:foreground ,green))))
   `(erc-keyword-face ((,class (:foreground ,yellow))))
   `(erc-current-nick-face ((,class (:foreground ,green))))
   `(erc-my-nick-face ((,class (:foreground ,green))))
   `(erc-nick-default-face ((,class (:weight normal :foreground ,purple))))
   `(erc-nick-msg-face ((,class (:weight normal :foreground ,yellow))))
   `(erc-notice-face ((,class (:foreground ,comment))))
   `(erc-pal-face ((,class (:foreground ,orange))))
   `(erc-prompt-face ((,class (:foreground ,blue))))
   `(erc-timestamp-face ((,class (:foreground ,aqua))))
   `(erc-keyword-face ((,class (:foreground ,green))))

   ;; twittering-mode
   `(twittering-username-face ((,class (:inherit erc-pal-face))))
   `(twittering-uri-face ((,class (:foreground ,blue :inherit link))))
   `(twittering-timeline-header-face ((,class (:foreground ,green :weight bold))))
   `(twittering-timeline-footer-face ((,class (:inherit twittering-timeline-header-face))))

   `(custom-variable-tag ((,class (:foreground ,blue))))
   `(custom-group-tag ((,class (:foreground ,blue))))
   `(custom-state ((,class (:foreground ,green))))

   ;; ansi-term
   `(term ((,class (:foreground nil :background nil :inherit default))))
   `(term-color-black   ((,class (:foreground ,blue))))
   `(term-color-red     ((,class (:foreground ,red))))
   `(term-color-green   ((,class (:foreground ,green))))
   `(term-color-yellow  ((,class (:foreground ,orange))))
   `(term-color-blue    ((,class (:foreground ,blue))))
   `(term-color-magenta ((,class (:foreground ,purple))))
   `(term-color-cyan    ((,class (:foreground ,aqua))))
   `(term-color-white   ((,class (:foreground ,foreground-4)))))


  (custom-theme-set-variables
   'spacegray
   `(fci-rule-color ,current-line)
   `(vc-annotate-color-map
     '((20  . ,red)
       (40  . ,orange)
       (60  . ,yellow)
       (80  . ,green)
       (100 . ,aqua)
       (120 . ,blue)
       (140 . ,purple)
       (160 . ,red)
       (180 . ,orange)
       (200 . ,yellow)
       (220 . ,green)
       (240 . ,aqua)
       (260 . ,blue)
       (280 . ,purple)
       (300 . ,red)
       (320 . ,orange)
       (340 . ,yellow)
       (360 . ,green)))
   `(vc-annotate-very-old-color nil)
   `(vc-annotate-background nil)
   `(ansi-color-names-vector (vector ,foreground ,red ,green ,yellow ,blue ,purple ,aqua ,background))
   '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])))

;;;###autoload
(when (and (boundp 'custom-theme-load-path)
       load-file-name)
  ;; add theme folder to `custom-theme-load-path' when installing over MELPA
  (add-to-list 'custom-theme-load-path
           (file-name-as-directory (file-name-directory load-file-name))))



(provide-theme 'spacegray)
