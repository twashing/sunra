(use-package haskell-mode
  :ensure t
  :defer 2
  :config
  (progn
    (add-hook 'haskell-mode-hook 'haskell-indentation-mode)
    (add-hook 'haskell-mode-hook 'interactive-haskell-mode)

    ;(add-hook 'haskell-mode-hook #'haskell-indent)
    ;(add-hook 'haskell-mode-hook #'interactive-haskell-mode)
    ;(add-hook 'haskell-mode-hook #'haskell-decl-scan-mode)
    ;(add-hook 'haskell-mode-hook #'haskell-doc-mode)
    ))

(provide 'sunra-haskell)

