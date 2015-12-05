(use-package scala-mode2
  :defer t)

(use-package ensime  
  :defer t
  :config
  (progn
    (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)))

(provide 'sunra-scala)
