(use-package magit 
  :ensure t)

(use-package projectile 
  :ensure t)
  
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package smartparens
  :ensure t
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)))
    
(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'lisp-interaction-mode-hook #'rainbow-delimiters-mode))

(use-package smart-mode-line
  :ensure t
  :init (setq sml/no-confirm-load-theme t)
  :config 
  (progn
    (sml/setup)
    (sml/apply-theme 'smart-mode-line-dark)))
