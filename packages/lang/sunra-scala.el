(use-package scala-mode2)

(use-package ensime
  :config
  (progn
    (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)))

(provide 'sunra-scala)
