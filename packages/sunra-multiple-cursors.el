
(use-package multiple-cursors

  :ensure t
  
  :bind (("C-c m n l" . mc/mark-next-lines)
	       ("C-c m n t" . mc/mark-next-like-this)
	       ("C-c m n w" . mc/mark-next-like-this-word)
	       ("C-c m n W" . mc/mark-next-word-like-this)
	       ("C-c m n s" . mc/mark-next-like-this-symbol)
	       ("C-c m n S" . mc/mark-next-symbol-like-this)
	       ("C-c m p l" . mc/mark-previous-lines)

	       ("C-c s n" . mc/skip-to-next-like-this)
	       ("C-c s p" . mc/skip-to-previous-like-this)
	       ("C-c m i n" . mc/insert-numbers)

	       ("C-c m a t" . mc/mark-all-like-this)
	       ("C-c m a w" . mc/mark-all-words-like-this)
	       ("C-c m a s" . mc/mark-all-symbols-like-this)
	       ("C-c m a r" . mc/mark-all-in-region)
	       ("C-c m a x" . mc/mark-all-in-region-regexp)
	       ("C-c m a d" . mc/mark-all-like-this-dwim)
	       ("C-c m a D" . mc/mark-all-dwim)

	       ("C-c m e l" . mc/edit-lines)
	       ("C-c m e b" . mc/edit-beginnings-of-lines)
	       ("C-c m e e" . mc/edit-ends-of-lines))
  
  :config
  (setq
   ;; Start from 1 when inserting numbers
   mc/insert-numbers-default 1
   
   ;; Don't ask for confirmation on actions, just apply to all cursors
   mc/always-run-for-all t))

(provide 'sunra-multiple-cursors)





