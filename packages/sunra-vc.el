
(use-package magit

  :defer t
  :straight (magit :type git
                   :host github
                   :repo "magit/magit"
                   :branch "main")
  :commands (magit-status magit-file-dispatch)
  :bind (("C-x RET" . magit-status))
  :custom
  (magit-no-confirm '(stage-all-changes))

  ;; Update configuration for the magit commit message buffer
  ;; so as not to automatically break a commit message to a newline
  ;; once it hits the default column boundary
  (git-commit-fill-column 1000)
  (git-commit-summary-max-length 1000))

;; NOTE
;;
;; The case of git-gutter, the modus-themes, and Doom Emacs
;; https://protesilaos.com/codelog/2022-08-04-doom-git-gutter-modus-themes/
;;
;; Git Gutter in Emacs
;; https://ianyepan.github.io/posts/emacs-git-gutter/
(use-package git-gutter
  :ensure t
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.02))

(use-package git-gutter-fringe
  :ensure t
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

(provide 'sunra-vc)
