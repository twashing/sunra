

;; NOTE
;;
;; # nerd-icons vs all-the-icons
;; 
;; "nerd-icons" seems to be the more modern improvement over "all-the-icons".
;; https://github.com/rainstormstudio/nerd-icons.el
;; https://github.com/domtronn/all-the-icons.el
;; 
;; 
;; # Helper repositories
;; https://github.com/mohkale/all-the-icons-nerd-fonts
;; https://github.com/rainstormstudio/treemacs-nerd-icons
;; 
;; 
;; # Not Needed
;; 
;; Alexander-Miller/treemacs
;; https://github.com/rainstormstudio/treemacs-nerd-icons
;; https://github.com/protesilaos/dired-preview
;; 
;; 
;; # Solution
;; 
;; https://github.com/rainstormstudio/nerd-icons.el
;; alexluigit/dirvish           + extensions (supports nerd-icons)
;; doomemacs/themes (doom-one)
;; seagle0128/doom-modeline


(use-package nerd-icons

  :ensure t

  ;; TODO
  ;; Only run this if nerd fonts is not already installed
  ;; :init (nerd-icons-install-fonts t)
  )

(use-package doom-themes

  :ensure t

  :config

  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; ;; Enable custom neotree theme (nerd-icons must be installed!)
  ;; (doom-themes-neotree-config)
  ;; 
  ;; ;; or for treemacs users
  ;; (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  ;; (doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))


(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))


(provide 'sunra-theme)
