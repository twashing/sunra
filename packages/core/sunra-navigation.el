(defun copy-sexp-at-point ()
  (interactive)
  (kill-new (thing-at-point 'sexp)))

(defun delete-whitespace-except-one ()
  (interactive)
  (just-one-space -1))


(global-set-key (kbd "C-x M-x") 'isearch-forward-symbol-at-point)
(global-set-key (kbd "C-x C-g") 'grep-find)
(global-set-key (kbd "C-x C-m") 'magit-status)
(global-set-key (kbd "C-x M-o") 'crux-smart-open-line-above)
(global-set-key (kbd "C-x C-o") 'crux-smart-open-line)


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
(global-set-key (kbd "C-M-[") 'scroll-other-window-down)
(global-set-key (kbd "C-M-]") 'scroll-other-window)


;; Smart Parens Navigation
(global-set-key (kbd "C-x M-s u") 'sp-up-sexp)
(global-set-key (kbd "C-x M-s U") 'sp-backward-up-sexp)
(global-set-key (kbd "C-x M-s d") 'sp-down-sexp)
(global-set-key (kbd "C-x M-s D") 'sp-backward-down-sexp)

(global-set-key (kbd "C-M-n") 'sp-next-sexp)

(global-set-key (kbd "C-x M-s s") 'sp-forward-slurp-sexp)
(global-set-key (kbd "C-x M-s b") 'sp-forward-barf-sexp)
(global-set-key (kbd "C-x M-s S") 'sp-backward-slurp-sexp)
(global-set-key (kbd "C-x M-s B") 'sp-backward-barf-sexp)


(use-package smooth-scrolling)

(provide 'sunra-navigation)
