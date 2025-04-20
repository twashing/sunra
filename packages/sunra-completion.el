

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

(use-package embark

  :ensure t
  :bind

  ;; NOTE
  ;; This makes all minibuffers (including Magit’s) treat RET as “embark” rather than “submit.”
  ;;
  ;; :bind
  ;; (:map minibuffer-local-map
  ;;       (("C-m" . embark-dwim)
  ;;        …))
  ;;
  ;; Use "minibuffer-local-completion-map" not "minibuffer-local-map"
  ;; minibuffer-local-completion-map is only active when you’ve triggered minibuffer completion (e.g. M-x, git push prompt, etc.).
  ;; minibuffer-local-map is active in every minibuffer, even those that don’t do completion.
  
  (:map completion-in-region-mode-map
        (("C-." . embark-export)
         ("C-," . embark-collect)
         ("C-;" . embark-select)
         ("C-m" . embark-dwim)
         ("C-n" . embark-act)
         ("C-n" . embark-become)))

  (:map minibuffer-local-completion-map
        (("C-." . embark-export)
         ("C-," . embark-collect)
         ("C-;" . embark-select)
         ("C-m" . embark-dwim)
         ("C-n" . embark-act)
         ("C-n" . embark-become)))

  :init

  ;; NOTE
  ;;
  ;; Is there a way to add search to which-key instead of paging and hunting for a command?
  ;; https://www.reddit.com/r/emacs/comments/otjn19/comment/h6vyx9q/
  ;;
  ;; In searching the C-x prefix. First I typed C-x, then C-h to bring up the embark-prefix-help-command prompt.
  ;; Next I can (for example) type po ma to search for commands under C-x that have po and ma in their name in any order.
  (setq prefix-help-command #'embark-prefix-help-command)

  
  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  ;; :config
  ;; (add-to-list 'display-buffer-alist
  ;;              '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
  ;;                nil
  ;;                (window-parameters (mode-line-format . none))))
  )


(use-package embark-consult

  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))


(provide 'sunra-completion)
