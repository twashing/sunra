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

(use-package smex 
  :ensure t
  :config
  (progn
    (smex-initialize)
    (global-set-key (kbd "M-x") 'smex)))

(provide 'sunra-ido)
