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

(eval-when-compile
  (require 'use-package))
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant



(defmacro use-packages (&rest args)
   (cons 'progn 
	 (mapcar (lambda (pkg)
		   `(use-package ,pkg ,@(rest args)))
	      (first args))))

(setq emacs-dir (file-name-directory
                    (or (buffer-file-name) (file-chase-links load-file-name)))) 

(add-to-list 'load-path (concat emacs-dir "packages"))                   
(add-to-list 'load-path (concat emacs-dir "packages/core"))
(add-to-list 'load-path (concat emacs-dir "packages/lang"))
(add-to-list 'load-path (concat emacs-dir "packages/user"))

               
(use-packages (sunra-baseline
               sunra-baseline-packages
               ;;sunra-line-numbers  ;; remove
      	       sunra-ido  ;; remove
               sunra-git
	       sunra-navigation
	       sunra-markdown
	       sunra-multiplecursors
               sunra-yasnippet
      	       sunra-clojure
               sunra-elisp
               sunra-hy  ; remove
      	       sunra-haskell
               sunra-purescript
               sunra-scala
               sunra-web
	       sunra-theme))

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
