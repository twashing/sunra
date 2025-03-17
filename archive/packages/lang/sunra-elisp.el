
(add-hook 'lisp-interaction-mode-hook #'rainbow-delimiters-mode)
(add-hook 'lisp-interaction-mode-hook #'smartparens-strict-mode)

(add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook #'smartparens-strict-mode)


(provide 'sunra-elisp)
