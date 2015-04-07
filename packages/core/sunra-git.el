(use-package magit 
  ;:ensure t
  :defer t
  :diminish magit-auto-revert-mode)

(use-package diff-hl 
  ;:ensure t
  :defer t
  :config (global-diff-hl-mode))
  
(provide 'sunra-git)
