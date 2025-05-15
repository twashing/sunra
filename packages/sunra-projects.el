
(use-package projectile

  :defer t
  :straight (projectile :type git
                        :host github
                        :repo "bbatsov/projectile"
                        :branch "master")

  :init (progn
          (projectile-mode +1)
          (when (executable-find "rg")
            (setq projectile-ripgrep-executable "rg")))

  :bind (("C-c p" . projectile-command-map))
  
  :config
  (setq projectile-completion-system 'default)
  (setq projectile-project-search-path '( "~/Projects" ))
  (setq projectile-ripgrep-executable "rg"))

(provide 'sunra-projects)
