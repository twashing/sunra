(defun recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Open: " recentf-list nil t)))
    (when file
      (find-file file))))
      
(use-package recentf
  :ensure t
  :defer 2
  :config
  (progn
    (require 'recentf)
    (global-set-key (kbd "C-c f") 'recentf-ido-find-file)
    (setq recentf-max-saved-items 200
          recentf-max-menu-items 15)
    (recentf-mode +1)))
    
(provide 'sunra-recentf)
