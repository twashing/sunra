


;; Enable Org mode on opening a .notes file
(add-to-list 'auto-mode-alist '("\\.notes\\'" . org-mode))


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


(provide 'sunra-org)
