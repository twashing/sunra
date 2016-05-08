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
  :defer 0
  :config (which-func-mode 1))

(use-package browse-kill-ring
    :defer 0)
(use-package rainbow-delimiters
    :defer 0)
(use-package erc
    :defer 0)
(use-package groovy-mode
    :defer 0)

(use-package super-save
  :defer 0
  :config (progn
	    (super-save-mode +1)
	    (setq super-save-auto-save-when-idle t)))

(use-package crux
  :defer 0
  :config (progn
	    (crux-with-region-or-buffer indent-region)
	    (crux-with-region-or-buffer untabify)
	    ;; (add-hook 'before-save-hook 'crux-cleanup-buffer-or-region)
	    ;; (remove-hook 'before-save-hook 'crux-cleanup-buffer-or-region)
	    ))

(use-package which-key
  :defer 0
  :config (which-key-mode))

(use-package anzu
  :defer 0
  :config (progn
	    (global-anzu-mode +1)
	    (anzu-mode +1)))

(use-package beacon
  :defer 0
  :config (beacon-mode 1))

(use-package smart-mode-line
  :init (setq sml/no-confirm-load-theme t)
  :defer 0
  :config
  (progn
    (sml/setup)
    (sml/apply-theme 'smart-mode-line-dark)))

(use-package company
  :defer 0
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package projectile
    :defer 0)

(use-package hydra
  :defer 0
  :bind (("C-c m" . hydra-move/body)
	 ("C-c t r" . hydra-transpose/body)
	 ("C-c w" . hydra-window/body)
	 ("C-c O" . hydra-projectile-other-window/body)
	 ("C-c P" . hydra-projectile/body)
	 ("C-c S" . hydra-learn-sp/body)
	 ("C-c g" . hydra-goto/body)
	 ("C-c i" . hydra-ivy/body)))

(use-package helm-company
    :defer 0)

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

;; (require 'helm-config)

(use-package swiper
  :bind ("M-s" . swiper))

(use-package swiper-helm
  :defer 0)

(use-package avy
  :defer 0
  :config (progn
	    (avy-setup-default)))

(use-package ace-window
  :defer 0)

(use-package smartparens
  :defer 0
  :diminish smartparens-mode
  :config (progn
	    (require 'smartparens-config)
	    (smartparens-global-mode 1)
	    (show-paren-mode 1))
  :init
  (setq sp-highlight-pair-overlay nil))

;; (use-package baseline-functions)

(provide 'sunra-baseline-packages)
