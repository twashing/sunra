;;; sunra-completion.el --- Completion setup using Vertico -*- lexical-binding: t; -*-

;;; Commentary:

;; Provides minibuffer completion using Vertico.

;;; Code:

(use-package vertico
  :ensure t
  :straight (vertico :type git
                     :host github
                     :repo "minad/vertico"
                     :branch "main")
  :init
  (vertico-mode))

(provide 'sunra-completion)
;;; sunra-completion.el ends here
