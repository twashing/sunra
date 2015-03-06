
;; use package.el
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))) ;; For important compatibility libraries like cl-lib
(package-initialize)


;; Skip the default splash screen.
(setq inhibit-startup-message t)


;; Remove menu, tool, and scrolls
(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))


(setq user-full-name "Timothy Washington")
(setq user-mail-address "twashing@interruptsoftware.com")
(setq vc-follow-symlinks nil)
(setq debug-on-error t)


;; Require Common Lisp - http://www.aaronbedra.com/emacs.d/#sec-1
(require 'cl)


;; Use UTF-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(load-library "iso-transl")


;; Automatically save buffers before compiling
(setq compilation-ask-about-save nil)

;; backup policy - http://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
;; (setq make-backup-files nil)
(setq backup-directory-alist `(("." . "~/.emacs.backup")))
(auto-save-mode)


;; use-package
(setq package-enable-at-startup nil)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)


;; packages
(add-to-list 'load-path (concat user-emacs-directory "packages"))
(let* ((package-names '(sunra-magit
                        sunra-projectile
                        sunra-autopair
			sunra-smartmodeline)))
  (mapc (lambda (ech)
          (require ech))
        package-names))


(delete-selection-mode t)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq x-select-enable-clipboard t)
(setq frame-title-format '(buffer-file-name "%f" ("%b")))
(setq tab-width 2
      indent-tabs-mode nil)

(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))


