(use-package ido
  ;:ensure t
  :defer t
  :config
  (progn
    (setq ido-enable-flex-matching t)
    (setq ido-everywhere t)
    (ido-mode 1)))

(use-package ido-ubiquitous
  ;:ensure t
  :defer t
  )

(use-package flx-ido
  ;:ensure t
  :defer t
  )

(use-package smex 
  ;:ensure t
  :defer t
  :config
  (progn
    (smex-initialize)
    (global-set-key (kbd "M-x") 'smex)))

(provide 'sunra-ido)
