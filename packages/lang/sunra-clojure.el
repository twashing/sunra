(use-package clojure-mode
  :ensure t
  :config
  (progn
    (add-hook 'clojure-mode-hook #'paredit-mode)
    (add-hook 'clojure-mode-hook #'smartparens-strict-mode)
    (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
    
    (require 'auto-complete-config)
    ;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
    (setq ac-delay 0.0)
    ;;(setq ac-use-quick-help t)
    (setq ac-quick-help-delay 0.0)
    ;;(setq ac-use-fuzzy 1)
    ;;(setq ac-auto-start 1)
    ;;(setq ac-auto-show-menu 1)
    (ac-config-default)))

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
    (add-hook 'cider-repl-mode-hook #'paredit-mode)
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
	  (add-hook 'cider-repl-mode-hook 'ac-cider-setup)
    (defun set-auto-complete-as-completion-at-point-function ()
      (setq completion-at-point-functions '(auto-complete)))

    (add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
    (add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function))
  :config (progn
	    (add-to-list 'ac-modes 'cider-mode)
	    (add-to-list 'ac-modes 'cider-repl-mode)))


(use-package clj-refactor
  :ensure t
  :diminish clj-refactor-mode)
  :config (add-hook 'clojure-mode-hook (lambda ()
					 (clj-refactor-mode 1)
					 
					 ;; bindings: https://github.com/clojure-emacs/clj-refactor.el#usage
					 (cljr-add-keybindings-with-prefix "C-c C-m")))


(defun midje-mode-hide-hs ()
  (hs-minor-mode)
  (diminish 'hs-minor-mode))

(use-package midje-mode 
  :ensure t
  :diminish midje-mode
  :config (progn
	    (add-hook 'clojure-mode-hook 'midje-mode)
	    (add-hook 'clojure-mode-hook 'midje-mode-hide-hs)
	    (add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))))

(provide 'sunra-clojure)
