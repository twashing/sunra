
(use-package magit
  :ensure t
  :straight (magit :type git
                   :host github
                   :repo "magit/magit"
                   :branch "main")
  :commands (magit-status magit-file-dispatch)
  :bind (("C-x RET" . magit-status))
  :custom
  (magit-no-confirm '(stage-all-changes))
  (git-commit-fill-column 1000)
  (git-commit-summary-max-length 1000))

(provide 'sunra-vc)
