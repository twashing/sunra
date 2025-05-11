(require 'package)


;; NOTE
;;
;; # Bash
;; Command line example for how to remove & refresh a 3rd party package
;;
;; rm -rf ~/.emacs.d/straight/repos/gptel &&
;; emacs --batch \
;; -l ~/.emacs.d/init.el \
;; --eval="(straight-use-package 'gptel)"
;; 
;; # Emacs
;; This Emacs function will refresh Emacs entire configuration starting from this "~/.emacs.d/init.el" initialization script. Including potentially re-compiling any .elc files. It should operate in the same manner as the command line script above.
;; 
;; 
;; Regarding the linkage between these directories, I'm noting down
;; why we delete from "~/.emacs.d/straight/repos"
;; but byte compile "~/.emacs.d/elpa"
;; where we presumably expect to have compiled ".elc" files in "~/.emacs.d/straight/build"
;; 
;; ~/.emacs.d/elpa
;; ~/.emacs.d/straight/repos
;; ~/.emacs.d/straight/build
;; 
;; 
;; Linkage Explanation:
;; 
;; - **~/.emacs.d/straight/repos**: This directory is used by the *straight.el* package manager to store the source files of installed packages. When a package is installed, its code is cloned or fetched from a version control repository and placed in this directory. The purpose of deleting folders from here is to ensure that stale or outdated code is removed, forcing a fresh installation or update of the package when it is needed again.
;; 
;; - **~/.emacs.d/elpa**: This directory typically contains packages installed using the built-in package manager. The compiled version of Emacs Lisp files (i.e., `.elc` files) is usually placed in
;;  this directory after byte-compiling the original Emacs Lisp files (`.el`). We want to recompile from here because this library represents the installed packages that are loaded into Emacs.
;; 
;; - **~/.emacs.d/straight/build**: In this directory, *straight.el* compiles the packages that are stored in *~/.emacs.d/straight/repos*. When a package is built, its compiled files are placed in this directory. We do not delete these files directly because they represent the latest compiled versions of the packages they correspond to.
;; 
;; To summarize:
;; We delete from `straight/repos`... to remove source files to ensure a fresh install,
;; while we manage compiled files in `elpa` and `straight/build` without direct deletion... to maintain the current work done on those packages,
;;    ensuring that we're always loading the proper compiled code when we refresh configurations.

(defun refresh-emacs-configuration (&optional recompile?)
  "Refresh Emacs configuration by removing all repository and build directories."
  (interactive)
  (let ((repo-directories '("~/.emacs.d/straight/repos/"))
        (build-directories '("~/.emacs.d/straight/build/"
                             "~/.emacs.d/elpa/")))

    ;; Remove repos and .elc files
    (dolist (dir (append repo-directories build-directories))
      (print `(,(file-directory-p dir) ,dir))
      (when (file-directory-p dir)
        (delete-directory dir 'recursive)))

    ;; Reload the init file
    (load-file "~/.emacs.d/init.el")

    ;; Optionally recompile all .el files
    (when recompile?
      (dolist (build-dir build-directories)
        (byte-recompile-directory (expand-file-name build-dir) 0)))

    (message "Emacs configuration refreshed.")))


;; (refresh-emacs-configuration t)
;; (refresh-emacs-configuration)


(setq emacs-dir (file-name-directory
		 (or (buffer-file-name)
		     (file-chase-links load-file-name))))

(dolist (pkg '("packages" "packages/llm" "packages/navigation"))
  (add-to-list 'load-path (concat emacs-dir pkg)))

(defmacro use-packages (&rest packages)
  `(progn
     ,@(mapcar (lambda (pkg) `(require ,pkg))
               packages)))

(use-packages
  'sunra-base
  'sunra-core
  'sunra-keybinds
  'sunra-editor
  'sunra-desktop
  'sunra-navigation
  'sunra-llm
  'sunra-multiple-cursors
  'sunra-speech
  'sunra-windows
  'sunra-markdown
  'sunra-org
  'sunra-vc
  'sunra-projects
  'sunra-completion
  'sunra-theme
  'sunra-dired)
