(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/.autosaves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/.backup/")))
 '(package-selected-packages
   '(ace-window browse-kill-ring exec-path-from-shell expand-region
		free-keys gptel gptel-quick markdown-mode
		multiple-cursors rainbow-delimiters smartparens))
 '(package-vc-selected-packages
   '((gptel-quick :url "https://github.com/karthink/gptel-quick" :branch
		  "main"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 6.0)))))
