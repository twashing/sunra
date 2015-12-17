(use-package yasnippet
  :init (progn
	  (if (not (file-exists-p "~/.emacs.d/snippets"))
	      (make-directory "~/.emacs.d/snippets")))
  :config (progn
	    (yas-global-mode 1)
	    (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
	    (yas-load-directory "~/.emacs.d/snippets")))

(provide 'sunra-yasnippet)
