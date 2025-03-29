
;; Disable the splash screen (startup screen)
(setq inhibit-startup-screen t)


;; Remove menu, tool, and scrolls
(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))


;; Add MELPA to package archives if it's not already there.
;; Optionally, add nongnu as well.
(dolist (archive '(("melpa" . "https://melpa.org/packages/")
                   ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
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



(defalias 'yes-or-no-p 'y-or-n-p)

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


(provide 'sunra-base)

