
(use-package projectile
  :ensure t
  :straight (projectile :type git
                        :host github
                        :repo "bbatsov/projectile"
                        :branch "master")

  :init (projectile-mode +1)

  :bind (("C-c p" . projectile-command-map))
  
  :config
  (setq projectile-completion-system 'default)
  (setq projectile-project-search-path '(\"~/Projects\")))

(provide 'sunra-projects)
