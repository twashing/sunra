(use-package ido
  :ensure t
  :config
  (progn
    (setq ido-enable-flex-matching t)
    (setq ido-everywhere t)
    (ido-mode 1)))

(use-package ido-ubiquitous
  :ensure t)

(use-package flx-ido
  :ensure t)


(provide 'sunra-ido)
