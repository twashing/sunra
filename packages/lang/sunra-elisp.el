
(add-hook 'lisp-interaction-mode-hook #'rainbow-delimiters-mode)
;(add-hook 'lisp-interaction-mode-hook #'paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'smartparens-strict-mode)


(add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
;(add-hook 'emacs-lisp-mode-hook #'paredit-mode)
(add-hook 'emacs-lisp-mode-hook #'smartparens-strict-mode)

(global-set-key (kbd "C-d") 'sp-kill-sexp)


(provide 'sunra-elisp)
