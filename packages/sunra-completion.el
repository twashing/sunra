

(use-package vertico

  :ensure t
  :straight (vertico :type git
                     :host github
                     :repo "minad/vertico"
                     :branch "main")

  :custom
  (vertico-cycle t)  ;; Enable cycling for `vertico-next/previous`
  (vertico-buffer-display-action . (display-buffer-in-direction
                                    (direction . right)
                                    (window-width . 0.5)))

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

  :hook (after-init . (lambda ()

                        ;; `vertico-multiform-mode` is activated in the `after-init` hook
                        ;; instead of within the `init` block, preventing its toggling from a recursive minibuffer.

                        (vertico-multiform-mode)
                        (setq vertico-multiform-categories
                              '((imenu buffer mouse)
                                (consult-imenu buffer mouse)
                                (file buffer mouse)
                                (buffer buffer mouse)
                                (kill-ring buffer mouse)
                                (outline buffer mouse)
                                (mark buffer mouse)
                                (t reverse mouse)))))

  :config

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

  (setq vertico-multiform-commands
        '(;; ("^describe-*" unobtrusive)
          ;; (execute-extended-command unobtrusive)
          ;; ("^consult-.*" buffer)
          ;; ("^embark-.*" reverse)
          )))

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

(define-prefix-command 'sunra-M-m-map)
(global-set-key (kbd "M-m") 'sunra-M-m-map)

(use-package consult

  ;; Replace bindings. Lazily loaded by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ;; ("C-c k" . consult-kmacro)
         ;; ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)

         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer

         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)

         ;; Other custom bindings
         ;; ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ("M-y" . consult-yank-from-kill-ring)

         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)

         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)                  ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ;; ("M-s l" . consult-line)
         ;; ("M-s L" . consult-line-multi)
         ("M-m s s" . consult-line)
         ("M-m s S" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)

         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ;; ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ;; ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ("M-m s s" . consult-line)
         ("M-m s S" . consult-line-multi)

         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Tweak the register preview for `consult-register-load',
  ;; `consult-register-store' and the built-in commands.  This improves the
  ;; register formatting, adds thin separator lines, register sorting and hides
  ;; the window mode line.
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (keymap-set consult-narrow-map (concat consult-narrow-key " ?") #'consult-narrow-help)
)


(provide 'sunra-completion)
