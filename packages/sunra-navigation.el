
;; Consider the Emacs use-package macro
;; https://www.gnu.org/software/emacs/manual/html_node/use-package/
;;
;; References are also here.
;; Emacs: use-package essentials
;; https://www.youtube.com/watch?v=RaqtzemHFDU
;;
;; Create a configuration that employs use-package for lazy loading the smartparens package.
;; https://melpa.org/#/smartparens
;; https://github.com/Fuco1/smartparens
;; https://smartparens.readthedocs.io/en/latest/
;;
;; Ensure that the use-package smartparens configuration i. downloads the package
;; ii. But only load the package on first use
;; https://www.gnu.org/software/emacs/manual/html_node/use-package/Loading-basics.html
;;
;;
;;
;; Commentary:
;; Below is an example configuration using use-package for lazy-loading smartparens. This setup downloads smartparens if not already installed, and delays loading until a user command triggers smartparens-mode.
;;
;; #### Brief Explanation
;; This configuration employs :ensure to download the package during package initialization, and :commands to mark smartparens-mode as an autoloaded command. Lazy loading ensures that smartparens is only loaded into Emacs when a command referencing its autoloads is first invoked. The additional :config section customizes smartparens after it has been loaded.
;;
;; #### Example Code
;;
;;
;; #### How It Works
;; 1. The :ensure t directive makes package installation automatic if smartparens is not already available.
;; 2. The :commands smartparens-mode directive creates an autoload for smartparens-mode. This defers loading the full package until the first time the command is invoked (for example, by pressing "C-c s").
;; 3. The :init section optionally binds a key (here "C-c s") to trigger smartparens-mode without loading the package immediately at startup.
;; 4. The :config section is executed once smartparens is loaded. It requires the default configuration (smartparens-config) and applies any additional configuration settings.
;;
;; This configuration provides a practical approach for lazily loading smartparens, boosting Emacs startup performance by only loading the package on first use.


(use-package smartparens

  :ensure t

  :init
  (smartparens-mode)

  ;; :bind automatically defers loading until first use
  :bind ( :map smartparens-mode-map
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
	  ("DEL" . sp-backward-delete-char))

  :config

  ;; Load the default smartparens configuration.
  (require 'smartparens-config)

  ;; ;; Additional customization can be added here.
  ;; (setq sp-base-key-bindings 'paredit) ; Use keybindings similar to paredit
  ;; (setq sp-autoskip-closing-pair 'always)


  ;; (turn-on-smartparens-strict-mode)
  (sp-pair "(" nil :unless '(:rem sp-point-before-word-p))
  (sp-pair "{" nil :unless '(:rem sp-point-before-word-p))
  (sp-pair "[" nil :unless '(:rem sp-point-before-word-p)))


;; NAVIGATION
(fset 'buf-move-up "\C-u10\C-p")
(fset 'buf-move-down "\C-u10\C-n")

(map! :map global-map
      "C-x M-x" #'isearch-forward-symbol-at-point
      "M-U" #'buf-move-up
      "M-D" #'buf-move-down
      "C-d" #'sp-kill-sexp
      "C-M-l" #'transpose-lines
      "C-/" #'org-cycle-global)

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


;; ;; WINDOWS
(map! ;; TODO Avy
      "M-[" #'ace-select-window

      ;; TODO Ace Window
      "C-c M-[" #'ace-swap-window
      "C-x M-[" #'ace-delete-window
      ;; "M-y" #'browse-kill-ring
      "C-M-[" #'scroll-other-window-down
      "C-M-]" #'scroll-other-window
      "C-M-s" #'sp-splice-sexp
      "C-M-l" #'transpose-lines)

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
