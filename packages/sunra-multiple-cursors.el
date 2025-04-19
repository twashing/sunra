

;; NOTE
;; Multiple Cursors keybindings leverages defvar-keymap to enable "repeat-mode".
;; Ie it lets the user repeat the last keypress, to repeat the last command.

;; For example, for this configuration ("C-c m n l" . mc/mark-next-lines)...
;; typing "C-c m n l" invokes "mc/mark-next-lines".
;; Then repeated typing "l" (within a 2 second threshold) will repeat the most recent command.

(use-package multiple-cursors

  :ensure t

  :config
  (define-repeat-keymap mc/next-repeat-map "C-c m n"
    "l" mc/mark-next-lines
    "t" mc/mark-next-like-this
    "w" mc/mark-next-like-this-word
    "W" mc/mark-next-word-like-this
    "s" mc/mark-next-like-this-symbol
    "S" mc/mark-next-symbol-like-this)
  (define-repeat-keymap mc/prev-repeat-map "C-c m p"
    "l" mc/mark-previous-lines)
  (define-repeat-keymap mc/skip-repeat-map "C-c s"
    "n" mc/skip-to-next-like-this
    "p" mc/skip-to-previous-like-this)
  (define-repeat-keymap mc/all-repeat-map "C-c m a"
    "t" mc/mark-all-like-this
    "w" mc/mark-all-words-like-this
    "s" mc/mark-all-symbols-like-this
    "r" mc/mark-all-in-region
    "x" mc/mark-all-in-region-regexp
    "d" mc/mark-all-like-this-dwim
    "D" mc/mark-all-dwim)
  (define-repeat-keymap mc/edit-repeat-map "C-c m e"
    "l" mc/edit-lines
    "b" mc/edit-beginnings-of-lines
    "e" mc/edit-ends-of-lines)

  (global-set-key (kbd "C-c m i n") #'mc/insert-numbers)

  (setq
   ;; Start from 1 when inserting numbers
   mc/insert-numbers-default 1

   ;; Don't ask for confirmation on actions, just apply to all cursors
   mc/always-run-for-all t))


(provide 'sunra-multiple-cursors)
