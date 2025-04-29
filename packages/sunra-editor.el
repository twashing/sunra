

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


;; Copy Remote Region
(defun zipmap (keys values)
  (cl-pairlis keys values))

(defun sunra/avy-read-process-window-in-list (list)
  (mapcar
   (lambda (triplet)
     (let ((first (nth 0 triplet))
           (last (nth 2 triplet))
           line-number
           substring
           buffer
           selection-candidate)

       (save-window-excursion
         (select-window last)
         (goto-char first)

         (setq line-number (line-number-at-pos))
         (setq substring (buffer-substring-no-properties first (nth 1 triplet)))
         (setq buffer (window-buffer last))
         (setq selection-candidate (format "%d %s %s" line-number substring buffer)))

       (list selection-candidate line-number substring buffer)))
   list))

(defun sunra/avy-read-candidates-prompt (candidates)

  (let* ((cans (sunra/avy-read-process-window-in-list candidates))
         (hashes (mapcar (lambda (c)
                           (secure-hash 'sha1 (car c)))
                         cans))
         (cadidates-selections-hash (zipmap hashes candidates))

         ;; Take selection, get hash, compare
         (the-selection (completing-read "Select a match: " (mapcar #'car cans)))
         (the-selection-hash (secure-hash 'sha1 the-selection)))

    (alist-get the-selection-hash cadidates-selections-hash nil nil #'string=)))

(defun sunra/avy-read-candidates-return ()

  ;; Read candidates from User prompt
  (let* ((candidates (avy--read-candidates))
         (flat-cands (mapcar #'flatten-list candidates)))

    ;; Conditionally narrow candidates if many, or select the one
    (if (> (length flat-cands) 1)
       (sunra/avy-read-candidates-prompt flat-cands)
      (car flat-cands))))

(defun sunra/copy-remote-region ()
  (interactive)

  ;; Make avy wait a (practically) infinate amount of time
  (let ((avy-timeout-seconds most-positive-fixnum))

    (let* ((triplet-start (sunra/avy-read-candidates-return))
           (candidate-start-position-start (nth 0 triplet-start))
           (window (nth 2 triplet-start))

           (triplet-end (sunra/avy-read-candidates-return))
           (candidate-end-position-end (nth 1 triplet-end)))

      (save-window-excursion

        (select-window window)

        (kill-new
         (buffer-substring-no-properties
          candidate-start-position-start
          candidate-end-position-end))))))


;; Utilities
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

(defun copy-line (&optional arg)
  "Do a kill-line but copy rather than kill.  This function directly calls
  kill-line, so see documentation of kill-line for how to use it including prefix
  argument and relevant variables.  This function works by temporarily making the
  buffer read-only."
  (interactive "P")
  (let ((buffer-read-only t)
        (kill-read-only-ok t))
    (kill-line arg)))

(map! "C-M-SPC" #'delete-whitespace-except-one
      "C-," #'sunra/newline-above
      "C-." #'sunra/newline-below)

(use-package crux

  :defer t
  :init (global-set-key [remap move-beginning-of-line] #'crux-move-beginning-of-line))

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

      "C-M-\\" #'avy-goto-char-2
      "C-M-;" #'sunra/copy-remote-region)


(provide 'sunra-editor)
