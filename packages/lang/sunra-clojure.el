(use-package clojure-mode
  :defer 2
  :ensure t
  :bind ("C-d" . sp-kill-sexp)
  :config
  (progn
    ;(add-hook 'clojure-mode-hook #'paredit-mode)
    (add-hook 'clojure-mode-hook #'smartparens-strict-mode)
    (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)))

;; try 2 - http://martintrojer.github.io/clojure/2014/10/02/clojure-and-emacs-without-cider/
(defun get-clj-completions (prefix)
  (let* ((proc (inferior-lisp-proc))
	 (comint-filt (process-filter proc))
	 (kept ""))
    (set-process-filter proc (lambda (proc string) (setq kept (concat kept string))))
    (process-send-string proc (format "(complete.core/completions \"%s\")\n"
				      (substring-no-properties prefix)))
    (while (accept-process-output proc 0.1))
    (setq completions (read kept))
    (set-process-filter proc comint-filt)
    completions))

(defun company-infclj (command &optional arg &rest ignored)
  (interactive (list 'interactive))

  (cl-case command
    (interactive (company-begin-backend 'company-infclj))
    (prefix (and (eq major-mode 'inferior-lisp-mode)
		 (company-grab-symbol)))
    (candidates (get-clj-completions arg))))

;;(require 'company-etags)
;;(add-to-list 'company-etags-modes 'clojure-mode)
;;(add-to-list 'company-backends 'company-infclj)

(use-package cider
  :defer 2
  :ensure t
  ;;:bind ("C-d" . sp-kill-sexp)
  :bind ("M-d" . kill-sexp)
  :config
  (progn
    (add-hook 'cider-mode-hook #'eldoc-mode)
    (setq nrepl-log-messages t)
    (setq cider-show-error-buffer nil)
    (setq cider-prefer-local-resources t)
    (setq nrepl-buffer-name-separator "/")
    (setq nrepl-buffer-name-show-port t)
    (setq cider-repl-use-clojure-font-lock t)
    ;(add-hook 'cider-repl-mode-hook #'paredit-mode)
    (add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)
    (add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'cider-repl-mode-hook #'subword-mode)
    (add-hook 'cider-repl-mode-hook #'company-mode)
    (add-hook 'cider-mode-hook #'company-mode)))

(use-package ac-cider
  :ensure t
  :defer 2
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
  :defer 2
  :diminish clj-refactor-mode)
  :config (add-hook 'clojure-mode-hook (lambda ()
					 (clj-refactor-mode 1)

					 ;; typing / tries to automatically pull in a pre-defined require
					 ;; this breaks the act of pasting in a string with a /
					 ;; https://github.com/clojure-emacs/clj-refactor.el/wiki#customization
					 (setq cljr-magic-requires nil)
					 
					 ;; bindings: https://github.com/clojure-emacs/clj-refactor.el#usage
					 (cljr-add-keybindings-with-prefix "C-c C-m")))


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
