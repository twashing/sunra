
;; (live-load-config-file "bindings.el")
;; https://github.com/overtone/emacs-live/blob/master/packs/dev/bindings-pack/config/default-bindings.el

;;kill-other-buffers
;;xah-copy-line-or-region
;;xah-cut-line-or-region
;;delete-file-and-buffer
;;smart-open-line
;;  (global-set-key [(shift return)] 'smart-open-line)
;;delete form at point
;;delete whitespace on save
;;C-SPC drags parens to prev line


(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer
        (delq (current-buffer)
              (remove-if-not 'buffer-file-name (buffer-list)))))

; Copy Line: taken from http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html
(defun xah-copy-line-or-region ()
  "Copy current line, or text selection.
When `universal-argument' is called first, copy whole buffer (but respect `narrow-to-region')."
  (interactive)
  (let (p1 p2)
    (if (null current-prefix-arg)
        (progn (if (use-region-p)
                   (progn (setq p1 (region-beginning))
                          (setq p2 (region-end)))
                 (progn (setq p1 (line-beginning-position))
                        (setq p2 (line-end-position)))))
      (progn (setq p1 (point-min))
             (setq p2 (point-max))))
    (kill-ring-save p1 p2)))

; ; Cut Line
(defun xah-cut-line-or-region ()
  "Cut current line, or text selection.
When `universal-argument' is called first, cut whole buffer (but respect `narrow-to-region')."
  (interactive)
  (let (p1 p2)
    (if (null current-prefix-arg)
        (progn (if (use-region-p)
                   (progn (setq p1 (region-beginning))
                          (setq p2 (region-end)))
                 (progn (setq p1 (line-beginning-position))
                        (setq p2 (line-beginning-position 2)))))
      (progn (setq p1 (point-min))
             (setq p2 (point-max))))
    (kill-region p1 p2)))

;; Delete File and Buffer (http://emacsredux.com/blog/2013/04/03/delete-file-and-buffer/)
(defun delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (progn
          (delete-file filename)
          (message "Deleted file %s" filename)
          (kill-buffer))))))

;; Highlight current line (http://emacsredux.com/blog/2013/04/02/highlight-current-line/)
(global-hl-line-mode 1)
(hl-line-mode +1)


;; Open a line under the current one
(defun smart-open-line ()
  "Insert an empty line after the current line.
  Position the cursor at its beginning, according to the current mode."
    (interactive)
    (move-end-of-line nil)
    (newline-and-indent))

(global-set-key [(shift return)] 'smart-open-line)

