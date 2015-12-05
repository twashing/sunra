(use-package haskell-mode  
  :defer t
  :config
  (progn
    (require 'haskell-interactive-mode)
    (require 'haskell-process)
    (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
    (add-hook 'haskell-mode-hook 'interactive-haskell-mode)))

(provide 'sunra-haskell)

