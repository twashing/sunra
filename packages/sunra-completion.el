;;; sunra-completion.el --- Completion setup using Vertico -*- lexical-binding: t; -*-

;;; Commentary:

;; Provides minibuffer completion using Vertico.

;;; Code:

(use-package vertico
  :ensure t
  :straight (vertico :type git
                     :host github
                     :repo "minad/vertico"
                     :branch "main"
                     ;; :files (:defaults "extensions/*.el")
                     )

  :init (progn
          (vertico-mode)
          (require 'vertico-buffer)
          (require 'vertico-reverse)
          (require 'vertico-unobtrusive)
          (require 'vertico-mouse)
          (require 'vertico-multiform)
          (require 'vertico-directory)

          (vertico-multiform-mode))

  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))

  ;; Tidy shadowed file names
  ;; :hook (rfn-eshadow-update-overlay . vertico-directory-tidy)

  :config

  ;; Configure multiform per category
  (setq vertico-multiform-categories
        '((imenu buffer mouse)
          ;; (consult-imenu buffer mouse)
          (t reverse mouse)))

  ;; Configure multiform per command
  (setq vertico-multiform-commands
        '(("^describe-*" unobtrusive)
          ;; (execute-extended-command unobtrusive)
          ;; ("^consult-.*" buffer)
          ;; ("^embark-.*" reverse)
          )))


(provide 'sunra-completion)
;;; sunra-completion.el ends here
