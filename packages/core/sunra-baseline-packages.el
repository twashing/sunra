(font-lock-add-keywords
 nil '(("\\<\\(\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):\\)"
	1 font-lock-warning-face t)))

(use-package nyan-mode
  :if window-system
  :config (progn
	    (nyan-mode 1)
	    (setq nyan-bar-length 16
		  nyan-wavy-trail t)))

(use-package which-func
  :defer t
  :config (which-func-mode 1))

(use-package browse-kill-ring :defer t)
(use-package rainbow-delimiters :defer t)
(use-package erc :defer t)
(use-package groovy-mode :defer t)

(use-package super-save
  :config (progn
	    (super-save-mode +1)))

(use-package crux
  :config (progn
	    (crux-with-region-or-buffer indent-region)
	    (crux-with-region-or-buffer untabify)
	    ;; (add-hook 'before-save-hook 'crux-cleanup-buffer-or-region)
	    ;; (remove-hook 'before-save-hook 'crux-cleanup-buffer-or-region)
	    ))

(use-package beacon
  :config (beacon-mode 1))

(use-package smart-mode-line
  :init (setq sml/no-confirm-load-theme t)
  :defer 0
  :config
  (progn
    (sml/setup)
    (sml/apply-theme 'smart-mode-line-dark)))

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package projectile)

(use-package helm-company)

(require 'helm-config)
(use-package helm
  :bind (("M-x" . helm-M-x)
	 ("C-x b" . helm-buffers-list)
	 ("C-x C-b" . helm-buffers-list)
	 ("M-y" . helm-show-kill-ring)
	 ("C-x C-f" . helm-find-files))

  ;; stolen from ohai emacs - Make Helm look nice
  :config (progn

	    (setq-default helm-display-header-line nil
			  helm-autoresize-min-height 10
			  helm-autoresize-max-height 35
			  helm-split-window-in-side-p t

			  helm-M-x-fuzzy-match t
			  helm-buffers-fuzzy-matching t
			  helm-recentf-fuzzy-match t
			  helm-apropos-fuzzy-match t)

	    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
	    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
	    (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

	    (when (package-installed-p 'hydra)
	      (define-key helm-map (kbd "\\") 'hydra-helm/body))))


(use-package swiper
  :config (progn
	    (global-set-key (kbd "M-s") 'swiper)))

(use-package swiper-helm)

(use-package avy
  :config (progn
	    (avy-setup-default)))

(use-package ace-window)

(use-package smartparens
  :diminish smartparens-mode
  :config (progn
	    (require 'smartparens-config)
	    (smartparens-global-mode 1)
	    (show-paren-mode 1))
  :init
  (setq sp-highlight-pair-overlay nil))


(use-package hydra
  :config (progn
	    (global-set-key (kbd "C-c m") 'hydra-move/body)
	    (global-set-key (kbd "C-c t r") 'hydra-transpose/body)
	    (global-set-key (kbd "C-c w") 'hydra-window/body)
	    (global-set-key (kbd "C-c O") 'hydra-projectile-other-window/body)
	    (global-set-key (kbd "C-c P") 'hydra-projectile/body)
	    (global-set-key (kbd "C-c S") 'hydra-learn-sp/body)
	    (global-set-key (kbd "C-c g") 'hydra-goto/body)
	    (global-set-key (kbd "C-c i") 'hydra-ivy/body)))

(require 'baseline-functions)


(provide 'sunra-baseline-packages)
