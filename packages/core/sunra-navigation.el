
(defun copy-sexp-at-point ()
    (interactive)
      (kill-new (thing-at-point 'sexp)))

(defun delete-whitespace-except-one ()
  (interactive)
  (just-one-space -1))


;; Navigation
(fset 'buf-move-up "\C-u10\C-p")
(fset 'buf-move-down "\C-u10\C-n")

(global-set-key (kbd "M-U") 'buf-move-up)
(global-set-key (kbd "M-D") 'buf-move-down)
(global-set-key (kbd "C-d") 'sp-kill-sexp)
(global-set-key (kbd "C-M-k") 'copy-sexp-at-point)
(global-set-key (kbd "M-p") 'ace-window)
(global-set-key (kbd "M-y") 'browse-kill-ring)
(global-set-key (kbd "M-SPC") 'delete-whitespace-except-one)
(global-set-key (kbd "C-M-u") 'scroll-other-window-down)
(global-set-key (kbd "C-M-d") 'scroll-other-window)

scroll-other-window

;; Smart Parens Navigation
(global-set-key (kbd "C-M-u") 'sp-up-sexp)
(global-set-key (kbd "C-M-d") 'sp-down-sexp)

(global-set-key (kbd "C-M-n") 'sp-next-sexp)
(global-set-key (kbd "C-M-b") 'sp-beginning-of-sexp)

(global-set-key (kbd "C-M-j") 'sp-forward-slurp-sexp)
(global-set-key (kbd "C-M-y") 'sp-forward-barf-sexp)
(global-set-key (kbd "C-M-s") 'sp-backward-slurp-sexp)
(global-set-key (kbd "C-M-e") 'sp-backward-barf-sexp)


(use-package smooth-scrolling)

(provide 'sunra-navigation)
