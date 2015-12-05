(use-package clojure-mode
  :defer 2
  :ensure t
  :bind (("M-d" . sp-kill-sexp)
	 ("M-r" . sp-raise-sexp)
	 ("C-M-b" . sp-previous-sexp)
	 ("C-x M-e" . cider-eval-print-last-sexp))
  :config
  (progn
    (add-hook 'clojure-mode-hook #'smartparens-strict-mode)
    (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'clojure-mode-hook #'company-mode)))

(use-package cider
  :defer 2
  :ensure t
  :bind (("M-d" . sp-kill-sexp)
	 ("M-r" . sp-raise-sexp)
	 ("C-M-b" . sp-previous-sexp)
	 ("C-x M-e" . cider-eval-print-last-sexp))
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

(use-package company-mode)

(use-package ac-cider
  :ensure t
  :defer 2
  :init (progn
	  (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
	  ;;(add-hook 'cider-mode-hook 'ac-cider-setup)
	  ;;(add-hook 'cider-repl-mode-hook 'ac-cider-setup)

	  ;;(defun set-auto-complete-as-completion-at-point-function ()
	  ;;  (setq completion-at-point-functions '(auto-complete)))

	  ;;(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
	  ;;(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)
	  ))


(use-package cider-eval-sexp-fu
  :ensure t)

(use-package clj-refactor
  :ensure t
  ;;:defer 2
  ;;:diminish clj-refactor-mode)
  :config (add-hook 'clojure-mode-hook (lambda ()
					 (clj-refactor-mode 1)

					 ;; typing / tries to automatically pull in a pre-defined require
					 ;; this breaks the act of pasting in a string with a /
					 ;; https://github.com/clojure-emacs/clj-refactor.el/wiki#customization
					 (setq cljr-magic-requires nil)
					 
					 ;; bindings: https://github.com/clojure-emacs/clj-refactor.el#usage
					 (cljr-add-keybindings-with-prefix "C-c C-b"))))

(defun midje-mode-hide-hs ()
  (hs-minor-mode)
  (diminish 'hs-minor-mode))

(use-package midje-mode 
  :ensure t
  :defer 2
  :diminish midje-mode
  :config (progn
	    (add-hook 'clojure-mode-hook 'midje-mode)
	    (add-hook 'clojure-mode-hook 'midje-mode-hide-hs)
	    (add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))))

(provide 'sunra-clojure)
