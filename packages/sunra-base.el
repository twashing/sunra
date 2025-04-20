
;; Disable the splash screen (startup screen)
(setq inhibit-startup-screen t)


;; Remove menu, tool, and scrolls
(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))


;; gnu and non-gnu should already be present in 'package-archives
;; Listing here for documentation purposes
(dolist (archive '(("gnu" . "http://elpa.gnu.org/packages/")
		   ("nongnu" . "https://elpa.nongnu.org/nongnu/")
		   ("elpa" . "https://elpa.gnu.org/packages/")
                   ("melpa" . "https://melpa.org/packages/")))
  (add-to-list 'package-archives archive t))


;; No need to add GNU ELPA—it’s built-in.
;; Package initialization is done automatically in Emacs 27+,
;; but if you need to do it explicitly, you can:
;; (package-initialize)


;; In Emacs 30 you generally don’t have to force UTF‑8 the way older configurations did.
;; Modern Emacs now defaults to UTF‑8 for file I/O and internal processing. In many cases all you need is:
(set-default-coding-systems 'utf-8)

;; These are usually no longer necessary unless you have very specific requirements or are running Emacs in an unusual terminal environment.
;; Also, since the ISO transliteration functions (for example those bound via C-x 8) are now autoloaded when needed, you typically don’t need to explicitly load "iso-transl".
;; So in summary: For Emacs 30 most users can rely on its built‑in defaults (which are UTF‑8) without needing these extra lines in your init file.
;;
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system'utf-8)
;; (prefer-coding-system 'utf-8)



;; Problem
;; 
;; I was initially confused that something was spuriously adding the `custom-set-faces` and `custom-set-variables` forms in my `init.el`.
;; The mechanism adding those `custom-set-variables` and `custom-set-faces` forms to my init.el is the built-in Emacs customization system.
;; When you use the customize interface (M-x customize) or when packages automatically set customization variables, Emacs writes these settings to your init file by default.
;; 
;; Custom File Mechanism
;; 
;; `custom-file` is the variable that determines where Emacs stores customization information.
;; By default, when this variable is nil, Emacs adds customizations to your init file (usually `~/.emacs.d/init.el` or `~/.emacs`).
;; This solution redirects these customizations to a separate file... custom.el.

;; Store customizations in a separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; Create the custom file if it doesn't exist
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))

;; Load the custom file
(load custom-file)


;; Ensure *scratch* buffer has no preamble text.
(setq initial-scratch-message "")


(defalias 'yes-or-no-p 'y-or-n-p)


;; Set dirs for autosave, backup and org
(let ((org-dir "~/.emacs.d/.org/")
      (autosaves-dir "~/.emacs.d/.autosaves/\\1")
      (backup-dir "~/.emacs.d/.backup/"))

  (unless (file-directory-p org-dir)
    (make-directory org-dir t))

  (unless (file-directory-p autosaves-dir)
    (make-directory autosaves-dir t))

  (unless (file-directory-p backup-dir)
    (make-directory backup-dir t)))


(setq debug-on-error t

      ;; Disable backup files
      make-backup-files nil

      ;; Set *scratch* buffer to lisp-interaction-mode
      ;; https://emacsredux.com/blog/2014/07/25/configure-the-scratch-buffers-mode/
      ;; https://emacs.stackexchange.com/questions/3830/why-does-lisp-interaction-mode-exist-and-do-we-ever-need-it
      initial-major-mode 'lisp-interaction-mode


      ;; If you use `org' and don't want your org files in the default location below,
      ;; change `org-directory'. It must be set before org loads!
      org-directory "~/.emacs.d/.org/"

      ;; This determines the style of line numbers in effect. If set to `nil', line
      ;; numbers are disabled. For relative line numbers, set this to `relative'.
      display-line-numbers-type t

      ;; When minibuffer offers tab completion, make that case-insensitive
      ;; https://emacs.stackexchange.com/a/32408/10528
      completion-ignore-case t)


;; Use spaces instead of tabs for indentation
;; By default, Emacs indent behavior varies by major mode, and some modes use tabs by default.
;; The key setting here is `(setq-default indent-tabs-mode nil)`, which disables tab indentation for all buffers by default.
;; The other settings control the display width of tabs when they do appear and improve tab behavior for completion.
(setq-default indent-tabs-mode nil)   ; Use spaces instead of tabs
(setq-default tab-width 2)            ; Set width for tabs that must be used
(setq-default tab-always-indent 'complete) ; Make tab complete if point is after a word prefix


;; Enable auto-save-visited-mode globally.
(auto-save-visited-mode 1)


;; Globally setting font
(set-face-attribute 'default nil
                    :font (font-spec :family "PragmataPro Liga"
                                     :size 16
                                     :weight 'normal))


;; Enable desktop-save-mode to restore previously open files
(desktop-save-mode 1)

;; Set up a directory for saving desktop files.
(let ((desktop-dir "~/.emacs.d/desktop/"))

  (unless (file-directory-p desktop-dir)
    (make-directory desktop-dir t))

  (setq desktop-dirname desktop-dir
        desktop-path (list desktop-dir)
        desktop-auto-save-timeout 300) ; auto-save every 5 minutes

  (desktop-save-mode 1))

;; Configuring Steve Purcell's exec-path-from-shell package to
;; make Emacs use the $PATH set up by the user's shell
(use-package exec-path-from-shell
  :ensure t
  :if (memq system-type '(darwin gnu/linux))
  :config
  (let ((platform-bin (if (eq system-type 'darwin)
                          "/opt/homebrew/bin"
                        "/usr/local/bin")))
    (setenv "PATH" (concat platform-bin ":" (getenv "PATH")))
    (add-to-list 'exec-path platform-bin))
  (exec-path-from-shell-initialize))


;; Disable audible bell and use visible bell
(setq visible-bell t)
(setq ring-bell-function (lambda ()
  (invert-face 'mode-line)
  (run-with-timer 0.1 nil #'invert-face 'mode-line)))


;; NOTE - Emacs 30
;;
;; Problem
;; A. MacOS dictation doesn't work in Emacs 30 out of the box.
;; 
;; B. None of these functions seem to exist in Emacs 30.
;; (mac-auto-operator-composing-mode 1)
;; (mac-auto-operator-composition-mode 1)
;; (mac-auto-operator-composition-mode)
;; 
;; But mac-auto-operator-composition-mode has certainly existed in the past, as shown by this configuration.
;; https://github.com/howardabrams/dot-files/blob/master/emacs-mac.org
;; 
;; C. And setting this to nil still doesn't let MacOS dictation to input to an Emacs 30 buffer.
;; (when (eq system-type 'darwin)
;;   (setq default-input-method nil))
;;
;; Solution
;; It turns out that MacOS dictation not working in Emacs 30 is a known issue (bug#76765). This is a build-time toolchain issue rather than a configuration problem, which explains why the mac-auto-operator-composition-mode functions you mentioned don't exist in Emacs 30.

;; NOTE - Emacs 29
;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Configure straight.el to use use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Now you can use straight.el with use-package


;; Emacs "recursive editing" and "Recursive Minibuffer"
;;
;; How can I open multiple minibuffers in emacs?
;; https://stackoverflow.com/questions/16986762/how-can-i-open-multiple-minibuffers-in-emacs
;; 
;; Recursive Editing
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Recursive-Editing.html
;; 
;; Recursive Minibuffers
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Recursive-Mini.html
;; 
;; Emacs - Recursive Edit
;; https://www.youtube.com/watch?v=KJysP2WrwCw
(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode 1)


;; Needed for
;; sunra-desktop
;; sunra-multiple-cursors
(require 'cl-lib)


(provide 'sunra-base)
