

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

  ;; Configure multiform per category
  (setq vertico-multiform-categories
        '((imenu buffer mouse)
          ;; (consult-imenu buffer mouse)
          (t reverse mouse)))

  ;; TODO - After consult, embark
  ;; projectile minibuffer pop-ups


  ;; NOTE
  ;;
  ;; Configure multiform per command
  ;; https://github.com/minad/vertico?tab=readme-ov-file#configure-vertico-per-command-or-completion-category
  ;;
  ;; Toggle Display Modes
  ;; M-B	vertico-multiform-buffer
  ;; M-F	vertico-multiform-flat
  ;; M-G	vertico-multiform-grid
  ;; M-R	vertico-multiform-reverse
  ;; M-U	vertico-multiform-unobtrusive
  ;; M-V	vertico-multiform-vertical

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

;; NOTE
;;
;; Orderless selection, howto specify literal pattern is specified by its "Style dispatchers"
;; https://github.com/oantolin/orderless?tab=readme-ov-file#style-dispatchers
;;
;; ! modifies the component with orderless-not. Both !bad and bad! will match strings that do not contain the pattern bad.
;; & modifies the component with orderless-annotation. The pattern will match against the candidate’s annotation (cheesy mnemonic: andnotation!).
;; , uses orderless-initialism.
;; = uses orderless-literal.
;; ^ uses orderless-literal-prefix.
;; ~ uses orderless-flex.
;; % makes the string match ignoring diacritics and similar inflections on characters (it uses the function char-fold-to-regexp to do this).

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

;; NOTE
;;
;; # Main Commands
;;
;; embark-act
;; embark-dwim
;; embark-collect
;; embark-export
;; embark-select
;; embark-become
;;
;;
;; # embark-collect vs embark-export
;;
;; Working with sets of possible targets
;; https://github.com/oantolin/embark?tab=readme-ov-file#working-with-sets-of-possible-targets
;;
;; "The embark-collect command produces a buffer listing all the current candidates, for you to peruse and run actions on at your leisure. The candidates are displayed as a list showing additional annotations. If any of the candidates contain newlines, then horizontal lines are used to separate candidates. ...
;; The embark-export command tries to open a buffer in an appropriate major mode for the set of candidates. If the candidates are files export produces a Dired buffer; if they are buffers, you get an Ibuffer buffer; and if they are packages you get a buffer in package menu mode.
;;
;; When in doubt choosing between exporting and collecting, a good rule of thumb is to always prefer embark-export since when an exporter to a special major mode is available for a given type of target, it will be more featureful than an Embark collect buffer, and if no such exporter is configured the embark-export command falls back to the generic embark-collect."
;;
;;
;; # Go "Back" from embark-collect or embark-export
;;
;; "In Embark Collect or Embark Export buffers that were obtained by running embark-collect or embark-export from within a minibuffer completion session,
;; "g" is bound to a command that restarts the completion session..."
;;
;;
;; # Explore
;;
;; act on file (incl. insert file path into buffer (from find file))
;; act on directory
;; act on variable
;; "C-u embark-act" (will keep the selection buffer open) ... (emark-act-noexit (no longer exists))
;; embark-become lets you switch the target action, using the same (already entered input) input. In essence to go back to the embark-act menu, or reverse from an embark-act

(use-package embark

  :ensure t
  :bind (("C->" . embark-export)
         ("C-<" . embark-collect)
         ("C-:" . embark-select)
         ("C-M-\"" . embark-dwim)
         ("C-\"" . embark-act)
         ("C-{" . embark-become))

  ;; TODO
  ;; completions (file, )
  ;; file
  ;; region
  ;; symbol


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
