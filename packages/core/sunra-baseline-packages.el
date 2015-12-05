
(if window-system
    (use-package nyan-mode
      :config (progn
		(nyan-mode 1)
		(setq nyan-bar-length 16
		      nyan-wavy-trail t))))

(font-lock-add-keywords
   nil '(("\\<\\(\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):\\)"
	  1 font-lock-warning-face t)))

(use-package which-func
  :defer t
  :config (which-func-mode 1))

(use-package browse-kill-ring
  :defer t)

(use-package smart-mode-line
  :init (setq sml/no-confirm-load-theme t)
  :config 
  (progn
    (sml/setup)
    (sml/apply-theme 'smart-mode-line-dark)))

(use-package company
  :defer t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package projectile
  :config (progn
	    (projectile-global-mode)))

(use-package helm-projectile)
(use-package helm-company)
(use-package helm-config)
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
			  helm-apropos-fuzzy-match t)))

(use-package beacon
  :config (beacon-mode 1))

(use-package swiper
  :config (progn
	    (global-set-key (kbd "M-s") 'swiper)))

(use-package swiper-helm)

(use-package avy
  :config (progn
	    (avy-setup-default)
	    (global-set-key (kbd "C-M-[") 'avy-goto-char)
	    (global-set-key (kbd "C-M-]") 'avy-goto-char-2)
	    (global-set-key (kbd "M-g f") 'avy-goto-line)
	    (global-set-key (kbd "M-g w") 'avy-goto-word-1)
	    (global-set-key (kbd "M-g e") 'avy-goto-word-0)))

(use-package ace-window
  :config (progn
	    (global-set-key (kbd "M-p") 'ace-window)))

(use-package projectile 
  :config
  (progn
    (global-set-key (kbd "s-t") 'projectile-find-file)
    (global-set-key (kbd "C-c C-f") 'projectile-find-file)))


(use-package smartparens
  :diminish smartparens-mode
  :bind (("C-d" . sp-kill-sexp))
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)
    (show-paren-mode 1))
  :init
  (setq sp-highlight-pair-overlay nil))

(use-package rainbow-delimiters
  :defer t)

(use-package erc
  :defer t)

(use-package groovy-mode
  :defer t)

(provide 'sunra-baseline-packages)
