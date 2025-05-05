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



;; ;; Q
;; The "\"C-c f\" . dirvish" keybinding (in the "use-package dirvish" configuration) in the file "packages/sunra-dired.el" is not working.
;; 
;; Based on the configuration under this directory, what's the root cause and solution?
;; Be clear and concise and focus on the solution code.



;; ;; Q
;; The "\"C-c f\" . dirvish" keybinding (in the "use-package dirvish" configuration) in the file "packages/sunra-dired.el" is not working.
;; https://github.com/twashing/sunra/blob/emacs-from-scratch/packages/navigation/sunra-dired.el
;; 
;; Based on the configuration under this repository, what's the root cause and solution?
;; https://github.com/twashing/sunra/tree/emacs-from-scratch
;; 
;; Be clear and concise and focus on the solution code.
