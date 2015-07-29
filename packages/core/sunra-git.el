(use-package magit 
  :ensure t
  :defer 2
  ;;:diminish magit-auto-revert-mode
  )

(use-package diff-hl 
  :ensure t
  :defer 2
  :config (global-diff-hl-mode))

(provide 'sunra-git)
