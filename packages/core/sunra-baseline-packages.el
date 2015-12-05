(use-package smart-mode-line
  :ensure t
  :init (setq sml/no-confirm-load-theme t)
  :config 
  (progn
    (sml/setup)
    (sml/apply-theme 'smart-mode-line-dark)))

;;(use-package nyan-mode
;;  :ensure t
;;  :config (nyan-mode 1))

;;(require 'whitespace)
;;(setq whitespace-line-column 80) ;; limit line length
;;(setq whitespace-style '(face tabs trailing lines-tail))
;;(add-hook 'prog-mode-hook (lambda nil (whitespace-mode +1)))
;;(setq whitespace-action '(auto-cleanup))

(use-package company
  :ensure t
  :defer 2
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package projectile
  :ensure t
  :config (progn
	    (projectile-global-mode)))

(use-package helm-projectile
  :ensure t)

(use-package helm-company
  :ensure t)

(require 'helm-config)

(use-package helm
  :ensure t
  :config
  (progn
    (global-set-key (kbd "M-x") 'helm-M-x)
    (global-set-key (kbd "C-x b") 'helm-buffers-list)
    (global-set-key (kbd "C-x C-b") 'helm-buffers-list)
    (global-set-key (kbd "M-y") 'helm-show-kill-ring)
    (global-set-key (kbd "C-x C-f") 'helm-find-files)

    ;; stolen from ohai emacs - Make Helm look nice
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
  :ensure t)

(use-package swiper-helm
  :ensure t
  :config (progn
	    (global-set-key (kbd "C-s") 'swiper)))

(use-package avy
  :ensure t
  :config (progn
	    (avy-setup-default)
	    (global-set-key (kbd "C-M-[") 'avy-goto-char)
	    (global-set-key (kbd "C-M-]") 'avy-goto-char-2)
	    (global-set-key (kbd "M-g f") 'avy-goto-line)
	    (global-set-key (kbd "M-g w") 'avy-goto-word-1)
	    (global-set-key (kbd "M-g e") 'avy-goto-word-0)))

(use-package ace-window
  :ensure t
  :config (progn
	    (global-set-key (kbd "M-p") 'ace-window)))

(use-package projectile 
  ;:ensure t
  :defer 2
  :config
  (progn
    (global-set-key (kbd "s-t") 'projectile-find-file)
    (global-set-key (kbd "C-c C-f") 'projectile-find-file)))
  
;; (use-package paredit
;;   ;:ensure t
;;   :defer t
;;   :diminish paredit-mode)
  
(use-package smartparens
  :ensure t
  :defer 2
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)
    (show-paren-mode 1))
  :init
  (setq sp-highlight-pair-overlay nil))

(use-package rainbow-delimiters
  :ensure t
  :defer 2)

(use-package erc
  :ensure t)

;;(use-package puppet-file
;;  :ensure)

;;(use-package puppetfile-mode
;;  :ensure)

(use-package groovy-mode
  :ensure t
  :defer 2)

(provide 'sunra-baseline-packages)
