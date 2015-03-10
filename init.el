(require 'cl)
(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))) ;; For important compatibility libraries like cl-lib
(package-initialize)

;; use-package
(setq package-enable-at-startup nil)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

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

(use-packages (sunra-core
               ;sunra-yasnippet
      	       sunra-clojure
               sunra-elisp
               sunra-hy
      	       ;sunra-haskell
               ;sunra-purescript
               ;sunra-scala
               ;sunra-web
               ))
