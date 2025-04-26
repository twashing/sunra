

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


;; NOTE
;;
;; Theme candidates
;; https://github.com/atom/atom/tree/master/packages/one-dark-ui   ;; doom-one
;; https://github.com/atom/atom/tree/master/packages/one-light-ui  ;; doom-one-light
;; https://github.com/biletskyy/flatwhite-syntax                   ;; doom-flatwhite
;; https://github.com/dempfi/ayu                                   ;; doom-ayu-dark doom-ayu-light doom-ayu-mirage
;; https://monokai.pro                                             ;; doom-molokai doom-monokai-classic doom-monokai-machine
;;                                                                    doom-monokai-octagon doom-monokai-pro
;;                                                                    doom-monokai-ristretto doom-monokai-spectrum
;; https://github.com/rougier/nano-theme                           ;; Nano theme + modeline
;; https://github.com/rougier/nano-modeline

;; (use-package doom-themes
;; 
;;   :ensure t
;; 
;;   :config
;; 
;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;; 
;;   ;; (load-theme 'doom-one t)
;;   ;; (load-theme 'doom-one-light t)
;;   (load-theme 'doom-flatwhite t)
;; 
;; 
;; 
;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)
;; 
;;   ;; ;; Enable custom neotree theme (nerd-icons must be installed!)
;;   ;; (doom-themes-neotree-config)
;;   ;;
;;   ;; ;; or for treemacs users
;;   ;; (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
;;   ;; (doom-themes-treemacs-config)
;; 
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config))

(use-package doom-themes

  :ensure t

  :custom
  (doom-themes-padded-modeline nil) ; Remove padding from modeline

  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t)  ; if nil, italics is universally disabled
  
  ;; (load-theme 'doom-one t)
  ;; (load-theme 'doom-one-light t)
  (load-theme 'doom-flatwhite t)
  
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
  
  ;; Customize window dividers
  (setq window-divider-default-right-width 1
  (setq window-divider-default-places 'right-only)
  (window-divider-mode 1)
  
  ;; Make vertical window dividers thinner and less visible
  (custom-set-faces
   '(vertical-border ((t (:foreground "#DDDDDD" :width condensed))))))


(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))


(provide 'sunra-theme)
