
(use-package ace-window
  :ensure t)

(use-package browse-kill-ring
  :ensure t)

(defun copy-sexp-at-point ()
    (interactive)
      (kill-new (thing-at-point 'sexp)))

(fset 'buf-move-up "\C-u10\C-p")
(fset 'buf-move-down "\C-u10\C-n")

(global-set-key (kbd "M-U") 'buf-move-up)
(global-set-key (kbd "M-D") 'buf-move-down)
(global-set-key (kbd "C-d") 'sp-kill-sexp)
(global-set-key (kbd "C-M-k") 'copy-sexp-at-point)
(global-set-key (kbd "M-p") 'ace-window)
(global-set-key (kbd "M-y") 'browse-kill-ring)


(provide 'sunra-navigation)
