

(use-package vertico

  :ensure t
  :straight (vertico :type git
                     :host github
                     :repo "minad/vertico"
                     :branch "main")

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

  ;; TODO - What is this
  ;; Tidy shadowed file names
  ;; :hook (rfn-eshadow-update-overlay . vertico-directory-tidy)

  :config

  ;; TODO - After consult, embark
  ;; Configure multiform per category
  (setq vertico-multiform-categories
        '((imenu buffer mouse)
          ;; (consult-imenu buffer mouse)
          (t reverse mouse)))

  ;; Configure multiform per command
  ;; (setq vertico-multiform-commands
  ;;       '(;; ("^describe-*" unobtrusive)
  ;;         ;; (execute-extended-command unobtrusive)
  ;;         ;; ("^consult-.*" buffer)
  ;;         ;; ("^embark-.*" reverse)
  ;;         ))
  )

(use-package marginalia

  :ensure t

  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  :init (marginalia-mode))


(use-package orderless

  :ensure t
  :custom
  ;; 1. Include both 'orderless' and 'partial-completion' in the global styles.
  ;;    'orderless' goes first for general matching and robustness.
  ;;    'partial-completion' enables the specific file path expansion.
  ;;    'flex' is often a good addition for flexible matching.
  (completion-styles '(orderless partial-completion flex))

  ;; 2. Configure orderless itself for robust handling, including empty input.
  ;;    'orderless-literal' ensures empty or exact matches work.
  ;;    'orderless-regexp' handles the component-wise regex matching.
  (orderless-matching-styles '(orderless-literal orderless-regexp))

  ;; 3. IMPORTANT: Do NOT add a completion-category-overrides for 'file'
  ;;    that excludes 'orderless'. Let 'file' completion use the global
  ;;    'completion-styles' defined above.
  )


(provide 'sunra-completion)
;;; sunra-completion.el ends here
