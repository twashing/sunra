(require 'package)


(setq emacs-dir (file-name-directory
		 (or (buffer-file-name)
		     (file-chase-links load-file-name))))

(dolist (pkg '("packages" "packages/llm"))
  (add-to-list 'load-path (concat emacs-dir pkg)))

(defmacro use-packages (&rest args)
  `(progn
     ,@(mapcar (lambda (pkg)
                 `(require ,pkg ,@(cdr args)))
               (car args))))


(use-packages ('sunra-base
	       'sunra-core
	       'sunra-keybinds
	       'sunra-navigation
	       'sunra-llm
	       ))

;; (let ((autosaves-dir "~/.emacs.d/.autosaves/\\1")
;;       (backup-dir "~/.emacs.d/.backup/"))
;;
;;   (unless (file-directory-p autosaves-dir)
;;     (make-directory autosaves-dir t))
;;
;;   (unless (file-directory-p backup-dir)
;;     (make-directory backup-dir t))
;;
;;   )


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/.autosaves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/.backup/" )))
 '(package-selected-packages '(gptel gptel-quick smartparens))
 '(package-vc-selected-packages
   '((gptel-quick :url "https://github.com/karthink/gptel-quick"
		  :branch "main"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
