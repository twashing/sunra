(use-package smart-mode-line
  :ensure t
  :init (setq sml/no-confirm-load-theme t)
  :config 
  (progn
    (sml/setup)
    (sml/apply-theme 'smart-mode-line-dark)))

(use-package company
  ;:ensure t
  :defer t
  :diminish company-mode
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package projectile 
  ;:ensure t
  :defer t
  :config
  (progn
    (global-set-key (kbd "s-t") 'projectile-find-file)
    (global-set-key (kbd "C-c C-f") 'projectile-find-file)))
  
(use-package paredit
  ;:ensure t
  :defer t
  :diminish paredit-mode)
  
(use-package smartparens
  :ensure t
  ;:defer t
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)
    (show-paren-mode 1)))
    
(use-package rainbow-delimiters
  ;:ensure t
  :defer t
  )
  
(provide 'sunra-baseline-packages)
