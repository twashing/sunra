
(use-package magit

  :defer t
  :straight (magit :type git
                   :host github
                   :repo "magit/magit"
                   :branch "main")
  :commands (magit-status magit-file-dispatch)
  :bind (("C-x RET" . magit-status))
  :custom
  (magit-no-confirm '(stage-all-changes))

  ;; Update configuration for the magit commit message buffer
  ;; so as not to automatically break a commit message to a newline
  ;; once it hits the default column boundary
  (git-commit-fill-column 1000)
  (git-commit-summary-max-length 1000))

(provide 'sunra-vc)
