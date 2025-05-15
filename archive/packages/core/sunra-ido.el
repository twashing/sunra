(use-package ido
  :defer 0
  :config
  (progn
    (setq ido-enable-flex-matching t)
    (setq ido-everywhere t)
    (ido-mode 1)))

(use-package ido-ubiquitous
  :defer 0)

(use-package flx-ido
  :defer 0)

(use-package smex 
  :bind ("C-M-x" . smex)
  :config
  (progn
    (smex-initialize)))

(defun recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Open: " recentf-list nil t)))
    (when file
      (find-file file))))
      
(use-package recentf
  :bind ("C-c f" . recentf-ido-find-file)
  :config
  (progn
    (require 'recentf)
    (setq recentf-max-saved-items 200
          recentf-max-menu-items 15)
    (recentf-mode +1)))

(provide 'sunra-ido)
