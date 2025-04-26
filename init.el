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

(defmacro use-packages (&rest args)
  `(progn
     ,@(mapcar (lambda (pkg)
                 `(require ,pkg ,@(cdr args)))
               (car args))))

(use-packages ('sunra-base
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
               'sunra-themes
               'sunra-dired))
