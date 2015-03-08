(use-package clojure-mode
  :ensure t
  :config
  (progn
    (add-hook 'clojure-mode-hook #'smartparens-strict-mode)
    (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)))

(use-package cider
  :ensure t
  :config
  (progn
    (add-hook 'cider-mode-hook #'eldoc-mode)
    (setq nrepl-log-messages t)
    (setq cider-show-error-buffer nil)
    (setq cider-prefer-local-resources t)
    (setq nrepl-buffer-name-separator "/")
    (setq nrepl-buffer-name-show-port t)
    (setq cider-repl-use-clojure-font-lock t)
    (add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)
    (add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'cider-repl-mode-hook #'subword-mode)
    (add-hook 'cider-repl-mode-hook #'company-mode)
    (add-hook 'cider-mode-hook #'company-mode)))

(use-package ac-cider
  :ensure t
  :init (progn
	  (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
	  (add-hook 'cider-mode-hook 'ac-cider-setup)
	  (add-hook 'cider-repl-mode-hook 'ac-cider-setup))
  :config (progn
	    (add-to-list 'ac-modes 'cider-mode)
	    (add-to-list 'ac-modes 'cider-repl-mode)))

(use-package clj-refactor
  :ensure t
  :config (add-hook 'clojure-mode-hook (lambda ()
					 (clj-refactor-mode 1)
					 
					 ;; bindings: https://github.com/clojure-emacs/clj-refactor.el#usage
					 (cljr-add-keybindings-with-prefix "C-c C-m"))))


(provide 'sunra-clojuremode)
