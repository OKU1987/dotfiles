(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "elisp" "elpa" "conf" "public_repos")

;; Enable package
(when (require 'package nil t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize))

;; Do not show startup messages
(setq inhibit-startup-message t
      inhibit-startup-screen t
      initial-scratch-message nil)

;; Ask y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; Show row and column of the cursor position
(setq column-number-mode t)

;; Highlight matching parenthesis
(show-paren-mode t)

;; Highlight selected region
(setq transient-mark-mode t)

;; Kill selected region by BS
(delete-selection-mode t)

;; Show line number
(global-linum-mode t)

;; Show column number
(column-number-mode t)

;; Highlight the current line
(global-hl-line-mode 0)

;; Do not blink cursor
(blink-cursor-mode nil)

;; Show special character (») for wrapped line end
(defface wrap-face
  '((((class color) (min-colors 88) (background dark))
     :foreground "aquamarine4")
    (((class color) (min-colors 88) (background light))
     :foreground "aquamarine2")
    (((class color) (min-colors 16))
     :foreground "DarkCyan")
    (((class color) (min-colors 8))
     :foreground "gray")
    (((type tty) (class mono))
     :inverse-video t))
  "Face of the wrap."
  :group 'convenience)
(set-display-table-slot standard-display-table 'wrap
                        (make-glyph-code #xbb 'wrap-face))

;; Highlight whitespace at EOL
(setq-default show-trailing-whitespace t)

;; Show buffer boundary indicator
(setq-default indicate-buffer-boundaries 'left)

;; C-x C-b shows buffer selector
(global-set-key (kbd "C-x C-b") 'bs-show)

;; Put directory names for the same name of different files
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Auto completion like IntelliSense
;; [Key Bindings]
;;   M-n  next candidate
;;   M-p  previous candidate
;;   TAB  do complete
;;   C-m  do complete
(when (require 'auto-complete nil t)
  (global-auto-complete-mode t)
  (setq ac-auto-show-menu 0.5))

;; Treat undo history as a tree
;; [Key Bindings]
;;   C-/    undo
;;   M-_    redo
;;   C-x u  show history as a tree
;;     p    go up the tree (undo)
;;     n    go down the tree (redo)
;;     f    select right branch of the tree
;;     b    select left branch of the tree
(when (require 'undo-tree nil t)
  (global-undo-tree-mode)
  (setq undo-tree-mode-lighter nil))

;; Highlight the current line on GDB source buffer
(defadvice gdb-display-source-buffer
  (after ad-hl-line-source-buffer (buffer) activate)
  (with-current-buffer buffer (hl-line-mode 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; proof general
(load-file "~/src/Proofgeneral-4.2/generic/proof-site.el")

(eval-after-load "proof-script" '(progn
  (define-key proof-mode-map "\C-c\C-j" 'proof-goto-point)
  (holes-mode 0)
  (custom-set-faces '(coq-cheat-face ((t (:background "red")))))
))

(setq overlay-arrow-string "")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(proof-locked-face ((t (:background "#202020")))))

;; ssreflect
(load-file "~/Coq/src/ssreflect-1.5/pg-ssr.el")

;; Other settings
t(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)
(define-key global-map (kbd "C-t") 'other-window)
(size-indication-mode t)
(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time-mode t)
(display-battery-mode t)

;; emacs-pervasives ends here