(use-package scala-mode2
  ;:ensure t
  :defer t
  )

(use-package ensime
  ;:ensure t
  :defer t
  :config
  (progn
    (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)))

(provide 'sunra-scala)
