(use-package hy-mode
  :defer 0
  :mode "\\.hy\\'"
  :config (progn
	    (add-hook 'hy-mode-hook #'rainbow-delimiters-mode)
	    (add-hook 'hy-mode-hook #'paredit-mode)))

(provide 'sunra-hy)


