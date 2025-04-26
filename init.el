(require 'package)


;; NOTE
;; rm -rf ~/.emacs.d/straight/repos/gptel &&
;; emacs --batch \
;; -l ~/.emacs.d/init.el \
;; --eval="(straight-use-package 'gptel)"


(setq emacs-dir (file-name-directory
		 (or (buffer-file-name)
		     (file-chase-links load-file-name))))

(dolist (pkg '("packages" "packages/llm" "packages/navigation"))
  (add-to-list 'load-path (concat emacs-dir pkg)))

;; (defmacro use-packages (&rest args)
;;   `(progn
;;      ,@(mapcar (lambda (pkg)
;;                  `(require ,pkg ,@(cdr args)))
;;                (car args))))
;; 
;; (use-packages ('sunra-base
;; 	             'sunra-core
;; 	             'sunra-desktop
;; 	             'sunra-keybinds
;; 	             'sunra-navigation
;; 	             'sunra-llm
;; 	             'sunra-multiple-cursors
;; 	             'sunra-speech
;; 	             'sunra-windows
;; 	             'sunra-markdown
;;                'sunra-org
;; 	             'sunra-vc
;;                'sunra-projects
;;                'sunra-completion
;;                'sunra-theme
;;                'sunra-dired))

(defmacro use-packages (&rest packages)
  `(progn
     ,@(mapcar (lambda (pkg) `(require ,pkg))
               packages)))

(use-packages 
  'sunra-base
  'sunra-core
  'sunra-desktop
  'sunra-keybinds
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

;; Evaluation of Packages:
;; Ensure those packages are loaded correctly using Elisp.
;; 
;; Observations:
;; 1. The code begins by requiring the `package` module, assuming it is needed for package management.
;; 2. The comment suggests a way to forcefully reinstall the `gptel` package.
;; 3. The calculation of `emacs-dir` provides a directory path based on the currently processing file or `load-file-name`.
;; 4. The `dolist` is utilized to add multiple package directories to the `load-path`.
;; 5. The `use-packages` macro is defined to require multiple packages listed in its argument.
;; 
;; #### Correction of `use-packages` macro
;; The macro's syntax with quoted `pkg` might lead to issues since it doesn't allow for proper evaluation of arguments. You should use unquoted forms for the packages argument.
;; 
;; Changing this:
;; ```elisp
;; (use-packages ('sunra-base
;;                'sunra-core
;;                ...))
;; ```
;; To:
;; ```elisp
;; (use-packages 
;;   'sunra-base
;;  
;;  'sunra-core
;;   ...)
;; ```
;; 
;; #### Package Requirement
;; The `require` function will be called correctly without needing an additional `progn`. The `mapcar` function currently nests `require` inside another form, leading to unnecessary complexity.
;; 
;; Modify the macro to:
;; ```elisp
;; (defmacro use-packages (&rest packages)
;;   `(progn
;;      ,@(mapcar (lambda (pkg) `(require ,pkg))
;;                packages)))
;; ```
;; 
;; #### Practical Application
;; Here’s a concise way to use the macro:
;; ```elisp
;; (use-packages 
;;   'sunra-base
;;   'sunra-core
;;   'sunra-desktop
;;   'sunra-keybinds
;;   'sunra-navigation
;;   'sunra-llm
;;   'sunra-multiple-cursors
;;   'sunra-speech
;;   'sunra-windows
;;   'sunra-markdown
;;   'sunra-org
;;   'sunra-vc
;;   'sunra-projects
;;   'sunra-completion
;;   'sunra-theme
;;   'sunra-dired)
;; ```
;; 
;; This will correctly require each listed package. 
;; 
;; #### Overall Evaluation
;; Make sure each of the packages you are loading is compatible with your current Emacs configuration. You could add error handling in the macro to manage missing packages gracefully if needed. For instance, you can catch errors during the `require` call and handle them appropriately.
;; 
;; By applying these adjustments, your package loading mechanism will be cleaner and more effective.
