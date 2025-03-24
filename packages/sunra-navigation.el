
(use-package smartparens

  :ensure t
  :init (smartparens-global-mode 1)
  :bind (:map global-map
	      ("C-M-k" . sp-copy-sexp)
	      ("C-M-u" . sp-up-sexp)
	      ("M-u" . sp-backward-up-sexp)
	      ("C-M-d" . sp-down-sexp)
	      ("M-d" . sp-backward-down-sexp)
	      ("C-M-j" . sp-forward-slurp-sexp)
	      ("C-x C-M-j" . sp-forward-barf-sexp)
	      ("C-M-y" . sp-backward-slurp-sexp)
	      ("C-x C-M-y" . sp-backward-barf-sexp)
	      ("C-M-n" . sp-next-sexp)
	      ("M-r" . sp-raise-sexp)
              ("C-M-s" . sp-splice-sexp)

	      ("DEL" . sp-backward-delete-char)
	      ("C-K" . sp-kill-hybrid-sexp))
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

  :ensure t
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
	aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package free-keys
  :ensure t)

(use-package browse-kill-ring
  :ensure t)

(use-package rainbow-delimiters
  :ensure t)


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
      "C-/" #'org-cycle-global)

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
      ;; TODO consult
      ;; "C-x <down>" #'consult-global-mark
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
