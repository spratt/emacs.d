;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Standard Emacs setup:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Fix the problem with tabs/spaces
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(setq auto-save-interval 900)
(setq default-major-mode 'text-mode)
(setq initial-major-mode 'text-mode)
(setq scroll-step 1)
(setq search-exit-char 13)
(put 'eval-expression 'disabled nil)
;; (setq auto-mode-alist (append '(("\\.php$" . c-mode)
;;                                 ("\\.lsp$" . lisp-mode)
;;                                 ("\\.txt$" . text-mode))
;;                               auto-mode-alist))
(setq completion-ignored-extensions
      (append '(".sparcf" ".sbin")
	      completion-ignored-extensions))
(setq version-control t)
(setq kept-new-versions 2)
(setq kept-old-versions 2)
(setq dired-kept-versions 0)
(setq trim-versions-without-asking t)
(transient-mark-mode t)
(setq fill-column 78)
(desktop-save-mode 1)
(setq mouse-wheel-scroll-amount '(0.01))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Mac-specific settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (equal system-type 'darwin)
  (progn
    ;; Fix the bug where emacs can't find git
    (setenv "PATH" (concat "/opt/local/bin:/usr/local/bin:" (getenv "PATH")))
    (push "/opt/local/bin" exec-path)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; When opening a cocoa window, as opposed to terminal
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (or
	(equal window-system 'mac)
	(equal window-system 'ns))
    (progn
      ;; When quitting emacs, save the list of open files so they can be
      ;; opened again next startup
      ;; Resize frame to ~1280x800
      (set-frame-height (selected-frame) 50)
      (set-frame-width (selected-frame) 171)
      ;; Split window in half for editing two files side-by-side
      (split-window-horizontally)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Set the backup and autosave directories to a central location
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar autosave-dir
  "~/.emacs.d/autosave/")

(make-directory autosave-dir t)

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat autosave-dir
   (if buffer-file-name
      (concat "#" (file-name-nondirectory buffer-file-name) "#")
    (expand-file-name
     (concat "#%" (buffer-name) "#")))))

(defvar backup-dir "~/.emacs.d/backup/")
(setq backup-directory-alist (list (cons "." backup-dir)))

;; Automagically delete excessive backups
(setq delete-old-versions t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Make newer Emacs more like the earlier 19 and 20
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (>= emacs-major-version 21)
  (when (not (equal window-system 'nil))
    ;; If we're using a window system,
    ;; Turn off the tool bar (icons)
    (tool-bar-mode 0)
    ;; Turn off the scroll bars
    (scroll-bar-mode -1))
  ;; Apparently this is like emacs 19
  (blink-cursor-mode 0)
  ;; Turn on image viewing
  (auto-image-file-mode t)
  ;; Turn on menu bar (this bar has text)
  (menu-bar-mode 0))

(defun set-window-width (n)
  "Set the selected window's width."
  (interactive "nSet window width:")
  (adjust-window-trailing-edge (selected-window) (- n (window-width)) t))

(defun window-term-width ()
  "Set the selected window's width to 80."
  (interactive)
  (set-window-width 80))

(global-set-key (kbd "C-*") 'window-term-width)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Personal Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq diary-file "~/Dropbox/Writing/diary.txt")

;; I hate seeing when people join or leave IRC
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

(put 'upcase-region 'disabled nil)

(setq split-height-threshold nil)
(setq split-width-threshold 0)
(put 'downcase-region 'disabled nil)


(when (>= emacs-major-version 24)
  (load "~/.emacs.d/init-packages")
  (load-theme 'tango-dark)
  (set-background-color "black"))
