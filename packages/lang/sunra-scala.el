(use-package scala-mode2
  :ensure t)

(use-package ensime
  :ensure t
  :config
  (progn
    (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)))

(provide 'sunra-scala)
