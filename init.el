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
		  `(require ,pkg ,@(rest args)))
		(first args))))

(setq emacs-dir (file-name-directory
		 (or (buffer-file-name) (file-chase-links load-file-name))))

(add-to-list 'load-path (concat emacs-dir "packages"))
(add-to-list 'load-path (concat emacs-dir "packages/core"))
(add-to-list 'load-path (concat emacs-dir "packages/core/baseline"))
(add-to-list 'load-path (concat emacs-dir "packages/lang"))
(add-to-list 'load-path (concat emacs-dir "packages/user"))

(use-packages ('sunra-baseline
	       'sunra-navigation
	       'sunra-baseline-packages
	       'sunra-ido  ;; remove
               'sunra-git
               'sunra-markdown
               'sunra-multiplecursors
               'sunra-yasnippet
               'sunra-clojure
               'sunra-elisp
               'sunra-hy
               'sunra-ruby
               'sunra-yaml
               'sunra-haskell
               'sunra-purescript
               ;; 'sunra-scala
               'sunra-web
	       'sunra-theme))


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
   "(do (require 'weasel.repl.websocket) (cemerick.piggieback/cljs-repl (weasel.repl.websocket/repl-env :ip \"127.0.0.1\" :port 9001)))")
 '(custom-safe-themes
   (quote
    ("561ba4316ba42fe75bc07a907647caa55fc883749ee4f8f280a29516525fc9e8" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages
   (quote
    (solarized-theme robe yari enh-ruby-mode yaml-mode use-package swiper-helm super-save smooth-scrolling smex smartparens smart-mode-line skewer-mode rainbow-delimiters psci projectile nyan-mode midje-mode markdown-mode magit ido-ubiquitous hy-mode helm-company haskell-mode groovy-mode git-gutter flx-ido ensime diff-hl cyberpunk-theme crux clojure-snippets clj-refactor cider-eval-sexp-fu browse-kill-ring beacon ace-window ac-cider))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line-inactive ((t (:background "black" :foreground "color-243" :inverse-video nil :box nil)))))
