(require 'cl)
(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))) ;; For important compatibility libraries like cl-lib
(package-initialize)
(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)


;; use-package
(setq package-enable-at-startup nil)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)

(eval-when-compile
  (require 'use-package))
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant

(defmacro use-packages (&rest args)
  (cons 'progn
	(mapcar (lambda (pkg)
		  `(use-package ,pkg :ensure nil ,@(rest args)))
		(first args))))

(setq emacs-dir (file-name-directory
		 (or (buffer-file-name) (file-chase-links load-file-name))))

(add-to-list 'load-path (concat emacs-dir "packages"))
(add-to-list 'load-path (concat emacs-dir "packages/core"))
(add-to-list 'load-path (concat emacs-dir "packages/lang"))
(add-to-list 'load-path (concat emacs-dir "packages/user"))

(use-packages (sunra-baseline
	       sunra-baseline-packages
	       sunra-ido  ;; remove
	       sunra-git
	       sunra-markdown
	       sunra-multiplecursors
	       sunra-yasnippet
	       sunra-clojure
	       sunra-elisp
	       sunra-hy
	       sunra-yaml
	       sunra-haskell
	       sunra-purescript
	       sunra-scala
	       sunra-web
	       sunra-theme))

(use-package sunra-navigation
  :defer 0
  :ensure nil)

;; Add: Frege, Ruby


;; User Localization
(defun create-nested-dirs (dirlist dirparent)
  (let* ((top (car dirlist)))
    (if top
	(let* ((dircombined (concat (file-name-as-directory dirparent)
				    (file-name-as-directory top))))
	  (message (file-name-as-directory dirparent))
	  (make-directory dircombined)
	  (create-nested-dirs (cdr dirlist) dircombined)))))

(defun create-user-dirs ()
  (let* ((local-packagedirs '(".sunra.d" "packages" "user"))
	 (local-sunradir "~"))

    (create-nested-dirs local-packagedirs local-sunradir)))


(if (not (file-exists-p "~/.sunra.d"))

    (progn

      ;; ask user if they want this created
      (create-user-dirs)

      ;; Copy userinit
      (copy-file "~/.emacs.d/packages/userinit.el"
		 "~/.sunra.d/init.el")

      ;; Copy sunra-theme.el
      (copy-file "~/.emacs.d/packages/user/sunra-theme.el"
		 "~/.sunra.d/packages/user/")))

;; Eval userinit
(load "~/.sunra.d/init.el")
(custom-set-variables

 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/.autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/.backup/"))))

 '(cider-cljs-lein-repl
   "(do (require 'weasel.repl.websocket) (cemerick.piggieback/cljs-repl (weasel.repl.websocket/repl-env :ip \"127.0.0.1\" :port 9001)))"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line-inactive ((t (:background "black" :foreground "color-243" :inverse-video nil :box nil)))))
