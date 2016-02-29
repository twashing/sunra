
(use-package enh-ruby-mode
  :ensure nil
  :defer 0
  :mode ("\\.rake$" "Rakefile$" "\\.gemspec$" "\\.ru$" "Gemfile$" "Guardfile$"))

(use-package yari
  :ensure nil
  :defer 0)

(use-package robe
  :ensure nil
  :bind (("C-c C-." . robe-bind))
  :config (progn
	    (add-hook 'enh-ruby-mode-hook 'robe-mode)
	    (add-hook 'ruby-mode-hook 'robe-mode)
	    (eval-after-load 'company
	      '(push 'company-robe company-backends))
	    (add-hook 'robe-mode-hook 'ac-robe-setup)))

(use-package rubocop
  :ensure nil
  :defer 0
  :config (progn
	    (add-hook 'ruby-mode-hook #'rubocop-mode)))

;; (use-package ruby-block)
;; (use-package ruby-end)


(provide 'sunra-ruby)
