
(use-package magit
  :ensure t
  :straight (magit :type git
                   :host github
                   :repo "magit/magit"
                   :branch "main")
  :commands (magit-status magit-file-dispatch)
  :bind (("C-x RET" . magit-status))
  :custom
  (magit-no-confirm '(stage-all-changes)))

(provide 'sunra-vc)
