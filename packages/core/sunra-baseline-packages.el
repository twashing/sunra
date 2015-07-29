(use-package smart-mode-line
  :ensure t
  :init (setq sml/no-confirm-load-theme t)
  :config 
  (progn
    (sml/setup)
    (sml/apply-theme 'smart-mode-line-dark)))

(use-package company
  :ensure t
  :defer 2
  :config
  (add-hook 'after-init-hook 'global-company-mode))

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

;;(use-package puppet-file
;;  :ensure)

;;(use-package puppetfile-mode
;;  :ensure)

(use-package groovy-mode
  :ensure t
  :defer 2)

(provide 'sunra-baseline-packages)
