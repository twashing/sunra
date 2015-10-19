(use-package haskell-mode
  :ensure t
  :defer 2
  :config
  (progn
    
    (require 'haskell-interactive-mode)
    (require 'haskell-process)
    (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
    (add-hook 'haskell-mode-hook 'interactive-haskell-mode)

    
    ))

(provide 'sunra-haskell)

