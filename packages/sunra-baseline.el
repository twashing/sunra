;; Skip the default splash screen.
(setq inhibit-startup-message t)

;; Remove menu, tool, and scrolls
(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))

(setq user-full-name "Chris Zheng")
(setq user-mail-address "z@caudate.me")
(setq vc-follow-symlinks nil)
(setq debug-on-error t)
(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)


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

(delete-selection-mode t)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq x-select-enable-clipboard t)
(setq frame-title-format '(buffer-file-name "%f" ("%b")))
(setq tab-width 2
      indent-tabs-mode nil)

(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))


(provide 'sunra-base)