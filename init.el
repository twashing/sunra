(require 'cl)

(add-to-list 'load-path (concat emacs-home "packages"))
(setq emacs-dir (file-name-directory
                    (or (buffer-file-name) (file-chase-links load-file-name))))
                    
(add-to-list 'load-path emacs-dir)
(use-packages (sunra-boot
               sunra-baseline
               sunra-baseline-packages
      	       sunra-recentf
      	       sunra-ido
      	       sunra-clojure
      	       sunra-haskell))