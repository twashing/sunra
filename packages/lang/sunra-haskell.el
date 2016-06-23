(use-package haskell-mode
  :config
  (progn
    (require 'haskell-interactive-mode)
    (require 'haskell-process)
    (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
    (add-hook 'haskell-mode-hook 'interactive-haskell-mode)

    ;; (autoload 'ghc-init "ghc" nil t)
    ;; (autoload 'ghc-debug "ghc" nil t)
    ;; (add-hook 'haskell-mode-hook (lambda () (ghc-init)))
    ))

(use-package shm
  :init (add-hook 'haskell-mode-hook 'structured-haskell-mode)
  :config
  (progn
    (when (require 'shm-case-split nil 'noerror)
      ;;TODO: Find some better bindings for case-splits
      (define-key shm-map (kbd "C-c S") 'shm/case-split)
      (define-key shm-map (kbd "C-c C-s") 'shm/do-case-split))

    (define-key shm-map (kbd "C-j") nil)
    (define-key shm-map (kbd "C-k") nil)))

(provide 'sunra-haskell)

