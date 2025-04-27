

;; Use spaces instead of tabs for indentation
;; By default, Emacs indent behavior varies by major mode, and some modes use tabs by default.
;; The key setting here is `(setq-default indent-tabs-mode nil)`, which disables tab indentation for all buffers by default.
;; The other settings control the display width of tabs when they do appear and improve tab behavior for completion.
(setq-default indent-tabs-mode nil)   ; Use spaces instead of tabs
(setq-default tab-width 2)            ; Set width for tabs that must be used
(setq-default tab-always-indent 'complete) ; Make tab complete if point is after a word prefix


;; NOTE
;;
;; Display line numbers and columns
;; https://www.gnu.org/software/emacs/manual/html_node/efaq/Displaying-the-current-line-or-column.html

(use-package display-line-numbers
  :ensure nil
  :hook ((text-mode . display-line-numbers-mode)
         (prog-mode . display-line-numbers-mode))
  :config
  (setq display-line-numbers-start-with-line 1))

(column-number-mode)


(provide 'sunra-editor)
