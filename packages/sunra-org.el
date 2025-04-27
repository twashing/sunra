

;; Enable Org mode on opening a .notes file
(add-to-list 'auto-mode-alist '("\\.notes\\'" . org-mode))


;; Automatically wrap lines in org mode
;; https://superuser.com/questions/299886/linewrap-in-org-mode-of-emacs
(setq org-startup-truncated nil
      truncate-lines nil)
;; (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
(setq org-ellipsis "…")
(setq org-hide-leading-stars t)
(setq org-agenda-files '("~/.emacs.d/.org"))
(add-hook 'org-mode-hook 'org-indent-mode)
(setq org-indent-mode-turns-on-hiding-stars t)
(setq org-agenda-span 'day)


;; Auto-indentation in org-mode only when a key prefix is supplied to <enter>.
;; This involves modifying the keymap to bind the auto-indentation function in conjunction with a prefix key.
;;
;; - `interactive "P"` allows the function to recognize prefix arguments.
;; - `newline` inserts a newline regardless of whether the prefix is supplied.
;; - If a prefix is provided, `org-indent-line` is called, which performs the auto-indentation.
;; - Finally, the original <enter> key binding in `org-mode` is replaced with your custom function.
;;
;; Now auto-indentation only occurs when you press a key prefix (like `C-u`) before hitting <enter> in org-mode.

(defun sunra/org-return-with-indent (arg)
  "Insert a newline and indent if a prefix ARG is provided."
  (interactive "P")  ; Get the prefix argument
  (newline)           ; Insert the newline
  (when arg            ; Check if the prefix argument is supplied
    (org-indent-line))) ; Indent the current line

;; Disable the default behavior of `org-return`
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "RET") #'sunra/org-return-with-indent))


;; TODO - fix
;;
;; (use-package org-modern
;;
;;   :ensure t
;;
;;   ;; :init
;;   ;; (with-eval-after-load 'org (global-org-modern-mode))
;;
;;   :config
;;
;;   ;; (set-face-attribute 'default nil :family "Iosevka")
;;   ;; (set-face-attribute 'variable-pitch nil :family "Iosevka Aile")
;;   ;; (set-face-attribute 'org-modern-symbol nil :family "Iosevka")
;;   (set-face-attribute 'default nil :family "PragmataPro Liga")
;;   (set-face-attribute 'variable-pitch nil :family "PragmataPro Liga")
;;   (set-face-attribute 'org-modern-symbol nil :family "PragmataPro Liga")
;;
;;   ;; ;; Add frame borders and window dividers
;;   ;; (modify-all-frames-parameters
;;   ;;  '((right-divider-width . 40)
;;   ;;    (internal-border-width . 40)))
;;   ;; (dolist (face '(window-divider
;;   ;;                 window-divider-first-pixel
;;   ;;                 window-divider-last-pixel))
;;   ;;   (face-spec-reset-face face)
;;   ;;   (set-face-foreground face (face-attribute 'default :background)))
;;   ;; (set-face-background 'fringe (face-attribute 'default :background))
;;
;;   (setq
;;    ;; Edit settings
;;    org-auto-align-tags nil
;;    org-tags-column 0
;;    org-catch-invisible-edits 'show-and-error
;;    org-special-ctrl-a/e t
;;    org-insert-heading-respect-content t
;;
;;    ;; Org styling, hide markup etc.
;;    org-hide-emphasis-markers t
;;    org-pretty-entities t
;;    org-agenda-tags-column 0
;;    ;; org-ellipsis "…"
;;    ))


(provide 'sunra-org)
