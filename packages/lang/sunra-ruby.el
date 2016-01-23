
(use-package enh-ruby-mode
  ;;:defer t
  :mode ("\\.rake$" "Rakefile$" "\\.gemspec$" "\\.ru$" "Gemfile$" "Guardfile$"))

(use-package yari)

(use-package robe
  :config (progn
	    (add-hook 'enh-ruby-mode-hook 'robe-mode)
	    (eval-after-load 'company
	      '(push 'company-robe company-backends))
	    (add-hook 'robe-mode-hook 'ac-robe-setup)))

;; (use-package ruby-block)
;; (use-package ruby-end)


(provide 'sunra-ruby)
