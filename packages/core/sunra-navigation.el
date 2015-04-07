
(fset 'buf-move-up "\C-u10\C-p")
(fset 'buf-move-down "\C-u10\C-n")

(global-set-key (kbd "M-U") 'buf-move-up)
(global-set-key (kbd "M-D") 'buf-move-down)

(global-set-key (kbd "C-d") 'sp-kill-sexp)

(provide 'sunra-navigation)
