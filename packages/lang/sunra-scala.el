(use-package scala-mode2
  :ensure t
  :defer 2)

(use-package ensime
  :ensure t
  :defer 2
  :config
  (progn
    (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)))

(provide 'sunra-scala)
