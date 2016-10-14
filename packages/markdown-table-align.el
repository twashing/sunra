
;; this functionality generously donated by Xiongtx: https://gist.github.com/xiongtx/0dc27ef54c477aba1dde88d9fb0731bb

(defun *-markdown-table-align (beg end)
  (interactive (list (org-table-begin) (org-table-end)))
  (save-excursion    
    (align-regexp beg end "\\(\\)|" 1 0 t)    
    (goto-char beg)
    (re-search-forward "|---" end t)    
    (subst-char-in-region (line-beginning-position)
                          (line-end-position)
                          ?\s ?- t)))

(define-prefix-command 'markdown-table-prefix-map)
(define-key markdown-mode-map (kbd "C-c C-t") 'markdown-table-prefix)
(define-key markdown-table-prefix-map (kbd "l") #'*-markdown-table-align)
