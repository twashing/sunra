(font-lock-add-keywords
   nil '(("\\<\\(\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):\\)"
	  1 font-lock-warning-face t)))

(use-package which-func
  ;:ensure t
  :defer t
  :config (which-func-mode 1))
    
(provide 'sunra-programming)
