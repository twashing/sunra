
(require 'package)


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

(setq debug-on-error t

      make-backup-files nil   ;; Disable backup files

      emacs-dir (file-name-directory
		 (or (buffer-file-name)
		     (file-chase-links load-file-name))))

;; Enable auto-save-visited-mode globally.
(auto-save-visited-mode 1)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/.autosaves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/.backup/")))
 '(package-selected-packages '(gptel)))


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


;;
;; Load Packages

(defun sunra/load! (file &optional noerror)
  "Load the Emacs Lisp FILE relative to the file this function is called from.
   Omit the file extension to allow Emacs to load the byte-compiled version if available.
   For example, (load! \"+git\") loads the file \"+git.el\" in the same directory."
  
  (let ((target (expand-file-name file (file-name-directory (or load-file-name buffer-file-name)))))
    (load target noerror)))

(dolist (pkg '("packages"))
  (add-to-list 'load-path (concat emacs-dir pkg)))

(defmacro use-packages (&rest args)
  (cons 'progn
	(mapcar (lambda (pkg)
		  `(require ,pkg ,@(rest args)))
		(first args))))

(use-packages ('sunra-llm))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
