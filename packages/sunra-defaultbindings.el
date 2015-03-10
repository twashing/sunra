(use-package defaultbindings
  :ensure t
  :config
  (progn

    ;; Many bits stolen liberally from emacs-live
    ;; https://github.com/overtone/emacs-live/blob/master/packs/dev/bindings-pack/config/default-bindings.el
    
    ;; Should be able to eval-and-replace anywhere.
    (global-set-key (kbd "C-c e") 'eval-and-replace)
    
    ))

(provide 'sunra-defaultbindings)
