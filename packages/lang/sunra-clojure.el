(use-package cider
  :bind (("M-d" . sp-kill-sexp)
	 ("M-r" . sp-raise-sexp)
	 ("C-M-b" . sp-previous-sexp)
	 ("C-x M-e" . cider-eval-print-last-sexp))
  :config
  (progn
    (add-hook 'cider-mode-hook #'eldoc-mode)
    
    (setq nrepl-log-messages t)
    (setq cider-show-error-buffer nil)
    (setq cider-auto-select-error-buffer nil)
    
    (setq cider-stacktrace-fill-column 1000)
    (setq cider-repl-pop-to-buffer-on-connect nil)
    (setq cider-prefer-local-resources t)
    (setq nrepl-buffer-name-separator "/")
    (setq nrepl-buffer-name-show-port t)
    (setq cider-repl-use-clojure-font-lock t)
    (setq cider-overlays-use-font-lock t)
    (setq cider-font-lock-dynamically '(macro core function var))
    (setq cider-prompt-for-symbol nil)
    (setq nrepl-hide-special-buffers t)
    (setq cider-prompt-save-file-on-load 'always-save)
    (setq cljr-suppress-middleware-warnings t)
    
    (add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)
    (add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'cider-repl-mode-hook #'subword-mode)
    (add-hook 'cider-repl-mode-hook #'company-mode)
    (add-hook 'cider-mode-hook #'company-mode)))

(use-package clojure-mode
  :bind (("M-d" . sp-kill-sexp)
	 ("M-r" . sp-raise-sexp)
	 ("C-M-b" . sp-previous-sexp)
	 ("C-x M-e" . cider-eval-print-last-sexp))
  :config
  (progn
    (add-hook 'clojure-mode-hook #'smartparens-strict-mode)
    (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'clojure-mode-hook #'company-mode)))

(use-package ac-cider
  :defer 0)
(use-package clojure-snippets
  :defer 0)


(use-package eval-sexp-fu
  :defer 0)
(use-package cider-eval-sexp-fu
  :defer 0)

(use-package clj-refactor
  :defer 0
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
  :defer 0
  :diminish midje-mode
  :config (progn
	    (add-hook 'clojure-mode-hook 'midje-mode)
	    (add-hook 'clojure-mode-hook 'midje-mode-hide-hs)
	    (add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))))

(provide 'sunra-clojure)
