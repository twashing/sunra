
(add-hook 'lisp-interaction-mode-hook #'rainbow-delimiters-mode)
(add-hook 'lisp-interaction-mode-hook #'paredit-mode)

(add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook #'paredit-mode)

(provide 'sunra-elisp)
