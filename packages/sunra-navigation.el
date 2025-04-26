
(use-package smartparens

  :ensure t
  :init (smartparens-global-mode 1)
  :bind (:map global-map
	            ("C-M-k" . sp-copy-sexp)
	            ("C-M-u" . sp-up-sexp)
	            ("M-u" . sp-backward-up-sexp)

              ("M-d" . sp-down-sexp)
	            ("C-M-d" . sp-backward-down-sexp)

              ("C-M-j" . sp-forward-slurp-sexp)
	            ("C-x C-M-j" . sp-forward-barf-sexp)
	            ("C-M-y" . sp-backward-slurp-sexp)
	            ("C-x C-M-y" . sp-backward-barf-sexp)
	            ("C-M-n" . sp-next-sexp)
	            ("M-r" . sp-raise-sexp)
              ("C-M-s" . sp-splice-sexp)
              ("C-M-t" . sp-transpose-sexp)



              ;; NOTE use case
              ;;
              ;; foo bar baz
              ;; (foo (bar (baz)))

              ("C-S-d" . sp-delete-word)   ;; deletes foo and foo
              ("C-d" . sp-kill-sexp)       ;; deletes foo and (foo ...)
	            ("DEL" . sp-backward-delete-char))
  :config

  ;; Load the default smartparens configuration.
  (require 'smartparens-config)

  ;; ;; Additional customization can be added here.
  (setq sp-base-key-bindings 'paredit) ; Use keybindings similar to paredit
  (setq sp-autoskip-closing-pair 'always)


  ;; (turn-on-smartparens-strict-mode)
  (sp-pair "(" nil :unless '(:rem sp-point-before-word-p))
  (sp-pair "{" nil :unless '(:rem sp-point-before-word-p))
  (sp-pair "[" nil :unless '(:rem sp-point-before-word-p)))


(use-package ace-window

  :defer t

  :bind (("M-[" . ace-select-window)
         ("C-c M-[" . ace-swap-window)
         ("C-x M-[" . ace-delete-window))

  :config

  ;; Switch window letter SIZE
  (custom-set-faces
   '(aw-leading-char-face
     ((t (:inherit ace-jump-face-foreground :height 6.0)))))

  ;; Ensure ace-window works across frames.
  (setq aw-scope 'global
        aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)

        ;; TODO set ace-jump-face-color
        aw-background nil))

(use-package free-keys
  :defer t)

(use-package browse-kill-ring
  :defer t)

(use-package rainbow-delimiters
  :defer t)

(use-package expand-region

  :defer t
  :bind (("C-=" . er/expand-region)
	       ("C-M-=" . er/contract-region)))


;; NAVIGATION
(fset 'buf-move-up "\C-u10\C-p")
(fset 'buf-move-down "\C-u10\C-n")

;; Define a globalized minor mode for hs-minor-mode
(dolist (hook '(prog-mode-hook org-mode-hook markdown-mode-hook latex-mode-hook))
  (add-hook hook #'hs-minor-mode))

(map! :map global-map
      "C-x M-x" #'isearch-forward-symbol-at-point
      "M-U" #'buf-move-up
      "M-D" #'buf-move-down
      "C-d" #'sp-kill-sexp
      "C-M-l" #'transpose-lines
      "C-/" #'org-cycle-global

      ;; NOTE
      ;;
      ;; # A
      ;;
      ;; These are the differences between these Emacs functions.
      ;;
      ;; kill-line
      ;; kill-whole-line
      ;; kill-visual-line
      ;; sp-kill-whole-line
      ;; avy-kill-whole-line
      ;;
      ;;
      ;; 1. *kill-line*: Kills (cuts) text from the current cursor position to the end of the line. It does not remove the newline character at the end of the line.
      ;;
      ;; 2. *kill-whole-line*: Kills the entire line, including the newline character, from the current cursor position. It effectively removes the line from the buffer.
      ;;
      ;; 3. *kill-visual-line*: Kills from the current cursor position to the end of the visual line, which may differ from the logical line if line wrapping is enabled.
      ;;
      ;; 4. *sp-kill-whole-line*: Part of the "smartparens" package, it kills the whole line, similar to =kill-whole-line=, with additional context sensitivity based on parentheses or similar structures.
      ;;
      ;; 5. *avy-kill-whole-line*: Part of the "avy" package, this function allows for quick line selection using Avy’s jump interface, then kills the selected whole line.
      ;;
      ;; Each function serves specific use cases based on how you want to manipulate text within a buffer.
      ;;
      ;;
      ;; # B
      ;; What are the differences between these Emacs functions. Be clear and concise.
      ;; crux-kill-whole-line
      ;; crux-smart-kill-line
      ;; crux-kill-line-backwards
      ;;
      ;;
      ;; Here are the differences between the three Emacs functions:
      ;;
      ;; 1. *=crux-kill-whole-line=*: Kills the entire line (including the newline character) where the cursor is positioned, regardless of the point's position within the line.
      ;;
      ;; 2. *=crux-smart-kill-line=*: Kills the line from the cursor's position to the end of the line, but it will keep the newline character if the cursor is at the beginning of the line. If not, it only kills up to the end of the line.
      ;;
      ;; 3. *=crux-kill-line-backwards=*: Kills everything from the cursor's position back to the beginning of the line, including the newline character if at the start of the line, effectively removing the line up to the cursor.
      ;;
      ;; In summary:
      ;; - =crux-kill-whole-line=: kills the whole line.
      ;; - =crux-smart-kill-line=: kills from cursor to end, preserves newline if at the start.
      ;; - =crux-kill-line-backwards=: kills from cursor to the beginning of the line.
      "C-k" #'crux-smart-kill-line
      "C-S-k" #'crux-kill-line-backwards
      "C-S-<backspace>" #'crux-kill-whole-line)

(map! "C-o" #'hs-toggle-hiding
      "C-c @ C-M-h" #'hs-hide-all
      "C-c @ C-M-s" #'hs-show-all
      "C-c @ C-M-l" #'hs-hide-level
      "C-M-," #'hs-hide-all
      "C-M-." #'hs-show-all
      "C-M-/" #'hs-hide-level)


;; EVALUATION
(map! :map global-map
      "C-c C-k" #'eval-buffer)


;; EDITING
(defun delete-whitespace-except-one ()
  (interactive)
  (just-one-space -1))

(defun sunra/newline-above ()
  "Insert an indented new line before the current one."
  (interactive)
  (beginning-of-line)
  (save-excursion (newline))
  (indent-according-to-mode))

(defun sunra/newline-below ()
  "Insert an indented new line after the current one."
  (interactive)
  (end-of-line)
  (newline-and-indent))

(map! "C-M-SPC" #'delete-whitespace-except-one
      "C-," #'sunra/newline-above
      "C-." #'sunra/newline-below)

(use-package crux

  :defer t
  :init (global-set-key [remap move-beginning-of-line] #'crux-move-beginning-of-line))

(defun copy-line (&optional arg)
  "Do a kill-line but copy rather than kill.  This function directly calls
  kill-line, so see documentation of kill-line for how to use it including prefix
  argument and relevant variables.  This function works by temporarily making the
  buffer read-only."
  (interactive "P")
  (let ((buffer-read-only t)
        (kill-read-only-ok t))
    (kill-line arg)))

(map! "C-c k" #'copy-line
      "C-c K" #'avy-copy-line)

(map! :map global-map

      "M-<backspace>" #'sp-backward-kill-word
      "C-c M-c" #'upcase-word
      "M-W" #'delete-trailing-whitespace
      "M-_" #'undo-redo

      ;; "M-m s o" #'consult-outline
      "C-c l e m" #'pp-macro-expand-last-expression
      "C-c l e D" #'eval-defun-at-point

      "C-x <up>" #'pop-global-mark
      "C-x <down>" #'consult-global-mark
      "C-M-<" #'append-to-buffer

      ;; TODO avy
      ;; "C->" #'avy-goto-char-timer
      ;; "C-M->" #'avy-goto-char-2

      ;; TODO embark
      ;; "C-M a" #'embark-act
      ;; "C-M e" #'embark-export
      ;; "C-M c" #'embark-collect

      ;; :dependencies (sunra-navigation)
      )


;; WINDOWS & FRAMES
(map! "M-y" #'browse-kill-ring
      "C-M-[" #'scroll-other-window-down
      "C-M-]" #'scroll-other-window
      "C-c o f" #'make-frame)


;; ;; VERSION CONTROL
;; ;; TODO magit
;; (map! :map global-map
;;
;;       "C-x RET" #'magit-status)


;; ;; PROJECTS
;; TODO projectile
;; (map! :map general-override-mode-map
;;       "M-m p p" #'projectile-switch-project
;;       "M-m p f" #'projectile-find-file
;;       "M-m p r" #'projectile-replace
;;       "M-m p R" #'projectile-replace-regexp
;;       "M-m p S" #'projectile-save-project-buffers)


(provide 'sunra-navigation)
