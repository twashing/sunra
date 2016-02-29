(use-package scala-mode2)

(use-package ensime
  :ensure nil
  :defer 0
  :config
  (progn
    (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)))

(provide 'sunra-scala)
