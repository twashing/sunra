
;; Auto Indent on newline
(define-key global-map (kbd "RET") 'newline-and-indent)



;; Show Column and Line Numbers  
(column-number-mode)

;; Highlight Current Line
(global-hl-line-mode 1)
(hl-line-mode +1)
(set-face-background 'hl-line "#171717")  ;; or #2E2E2E (http://www.w3schools.com/tags/ref_colorpicker.asp)

;; Indicate Empty Lines
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

;; Linum Mode 
(global-linum-mode)
(setq linum-format "%2d ")
(custom-set-faces  ;; should only be 1 of these (http://redbrain.co.uk/2013/11/11/my-dot-emacs-and-screenshot/)
  '(linum ((t (:foreground "#171717")))))

(defvar *linum-mdown-line* nil)

(defun line-at-click ()
  (save-excursion
	(let ((click-y (cdr (cdr (mouse-position))))
		  (line-move-visual-store line-move-visual))
	  (setq line-move-visual t)
	  (goto-char (window-start))
	  (next-line (1- click-y))
	  (setq line-move-visual line-move-visual-store)
	  ;; If you are using tabbar substitute the next line with
	  ;; (line-number-at-pos))))
	  (1+ (line-number-at-pos)))))

(defun md-select-linum ()
  (interactive)
  (goto-line (line-at-click))
  (set-mark (point))
  (setq *linum-mdown-line*
		(line-number-at-pos)))

(defun mu-select-linum ()
  (interactive)
  (when *linum-mdown-line*
	(let (mu-line)
	  ;; (goto-line (line-at-click))
	  (setq mu-line (line-at-click))
	  (goto-line (max *linum-mdown-line* mu-line))
	  (set-mark (line-end-position))
	  (goto-line (min *linum-mdown-line* mu-line))
	  (setq *linum-mdown*
			nil))))

(global-set-key (kbd "<left-margin> <down-mouse-1>") 'md-select-linum)
(global-set-key (kbd "<left-margin> <mouse-1>") 'mu-select-linum)
(global-set-key (kbd "<left-margin> <drag-mouse-1>") 'mu-select-linum)


(provide 'sunra-line-numbers)
