(font-lock-add-keywords
 nil '(("\\<\\(\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):\\)"
	1 font-lock-warning-face t)))

(use-package nyan-mode
  :if window-system
  :config (progn
	    (nyan-mode 1)
	    (setq nyan-bar-length 16
		  nyan-wavy-trail t)))

(use-package which-func
  :defer t
  :config (which-func-mode 1))

(use-package browse-kill-ring :defer t)
(use-package rainbow-delimiters :defer t)
(use-package erc :defer t)
(use-package groovy-mode :defer t)

(use-package super-save
  :config (progn
	    (super-save-mode +1)))

;; (use-package crux
;;   :config (progn
;; 	    (crux-with-region-or-buffer indent-region)
;; 	    (crux-with-region-or-buffer untabify)
;; 	    (add-hook 'before-save-hook 'crux-cleanup-buffer-or-region)))

(use-package beacon
  :config (beacon-mode 1))

(use-package smart-mode-line
  :init (setq sml/no-confirm-load-theme t)
  :defer 0
  :config
  (progn
    (sml/setup)
    (sml/apply-theme 'smart-mode-line-dark)))

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package projectile
  :defer t)

(use-package helm-company)

(require 'helm-config)
(use-package helm
  :bind (("M-x" . helm-M-x)
	 ("C-x b" . helm-buffers-list)
	 ("C-x C-b" . helm-buffers-list)
	 ("M-y" . helm-show-kill-ring)
	 ("C-x C-f" . helm-find-files))

  ;; stolen from ohai emacs - Make Helm look nice
  :config (progn

	    (setq-default helm-display-header-line nil
			  helm-autoresize-min-height 10
			  helm-autoresize-max-height 35
			  helm-split-window-in-side-p t

			  helm-M-x-fuzzy-match t
			  helm-buffers-fuzzy-matching t
			  helm-recentf-fuzzy-match t
			  helm-apropos-fuzzy-match t)

	    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
	    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
	    (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

	    (when (package-installed-p 'hydra)
	      (define-key helm-map (kbd "\\") 'hydra-helm/body)

	      ;; taken from:
	      ;; https://github.com/joedicastro/dotfiles/tree/master/emacs#helm
	      (defhydra hydra-helm (:hint nil :color pink)
		"
									  ╭──────┐
   Navigation   Other  Sources     Mark             Do             Help   │ Helm │
  ╭───────────────────────────────────────────────────────────────────────┴──────╯
	^_k_^         _K_       _p_   [_m_] mark         [_v_] view         [_H_] helm help
	^^↑^^         ^↑^       ^↑^   [_t_] toggle all   [_d_] delete       [_s_] source help
    _h_ ←   → _l_     _c_       ^ ^   [_u_] unmark all   [_f_] follow: %(helm-attr 'follow)
	^^↓^^         ^↓^       ^↓^    ^ ^               [_y_] yank selection
	^_j_^         _J_       _n_    ^ ^               [_w_] toggle windows
  --------------------------------------------------------------------------------
	"
		("<tab>" helm-keyboard-quit "back" :exit t)
		("<escape>" nil "quit")
		("\\" (insert "\\") "\\" :color blue)
		("h" helm-beginning-of-buffer)
		("j" helm-next-line)
		("k" helm-previous-line)
		("l" helm-end-of-buffer)
		("g" helm-beginning-of-buffer)
		("G" helm-end-of-buffer)
		("n" helm-next-source)
		("p" helm-previous-source)
		("K" helm-scroll-other-window-down)
		("J" helm-scroll-other-window)
		("c" helm-recenter-top-bottom-other-window)
		("m" helm-toggle-visible-mark)
		("t" helm-toggle-all-marks)
		("u" helm-unmark-all)
		("H" helm-help)
		("s" helm-buffer-help)
		("v" helm-execute-persistent-action)
		("d" helm-persistent-delete-marked)
		("y" helm-yank-selection)
		("w" helm-toggle-resplit-and-swap-windows)
		("f" helm-follow-mode)))
	    ))

(use-package swiper
  :config (progn
	    (global-set-key (kbd "M-s") 'swiper)))

(use-package swiper-helm)

(use-package avy
  :config (progn
	    (avy-setup-default)
	    ))

(use-package ace-window)

(use-package smartparens
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)
    (show-paren-mode 1))
  :init
  (setq sp-highlight-pair-overlay nil))


(use-package hydra
  :config (progn

	    ;; shamelessly stolen from:
	    ;; http://kitchingroup.cheme.cmu.edu/blog/2015/09/28/A-cursor-goto-hydra-for-emacs
	    (defhydra hydra-goto (:color blue :hint nil)
	      "
Goto:
^Char^              ^Word^                ^org^                    ^search^
^^^^^^^^---------------------------------------------------------------------------
_c_: 2 chars        _w_: word by char     _h_: headline in buffer  _o_: helm-occur
_C_: char           _W_: some word        _a_: heading in agenda   _p_: helm-swiper
_L_: char in line   _s_: subword by char  _q_: swoop org buffers   _f_: search forward
^  ^                _S_: some subword     ^ ^                      _b_: search backward
-----------------------------------------------------------------------------------
_B_: helm-buffers       _l_: avy-goto-line
_m_: helm-mini          _i_: ace-window
_R_: helm-recentf

_n_: Navigate           _._: mark position _/_: jump to mark
"
	      ("c" avy-goto-char-2)
	      ("C" avy-goto-char)
	      ("L" avy-goto-char-in-line)
	      ("w" avy-goto-word-1)
	      ;; jump to beginning of some word
	      ("W" avy-goto-word-0)
	      ;; jump to subword starting with a char
	      ("s" avy-goto-subword-1)
	      ;; jump to some subword
	      ("S" avy-goto-subword-0)

	      ("l" avy-goto-line)
	      ("i" ace-window)

	      ("h" helm-org-headlines)
	      ("a" helm-org-agenda-files-headings)
	      ("q" helm-multi-swoop-org)

	      ("o" helm-occur)
	      ("p" swiper-helm)

	      ("f" isearch-forward)
	      ("b" isearch-backward)

	      ("." org-mark-ring-push :color red)
	      ("/" org-mark-ring-goto :color blue)
	      ("B" helm-buffers-list)
	      ("m" helm-mini)
	      ("R" helm-recentf)
	      ("n" hydra-navigate/body))

	    (defhydra hydra-move
	      (:body-pre (next-line))
	      "move"
	      ("n" next-line "next line")
	      ("p" previous-line "previous line")
	      ("f" forward-char "forward char")
	      ("b" backward-char "backward char")
	      ("a" beginning-of-line "beginning of line")
	      ("e" move-end-of-line "end-of line")
	      ("v" scroll-up-command "scroll down")
	      ;; Converting M-v to V here by analogy.
	      ("V" scroll-down-command "scroll up")
	      ("l" recenter-top-bottom "centre buffer"))

	    (defhydra hydra-transpose (:color red)
	      "Transpose"
	      ("c" transpose-chars "characters")
	      ("w" transpose-words "words")
	      ("o" org-transpose-words "Org mode words")
	      ("l" transpose-lines "lines")
	      ("s" transpose-sentences "sentences")
	      ("e" org-transpose-elements "Org mode elements")
	      ("p" transpose-paragraphs "paragraphs")
	      ("t" org-table-transpose-table-at-point "Org mode table")
	      ("q" nil "cancel" :color blue))

	    (defhydra hydra-window ()
	      "
Movement^^        ^Split^         ^Switch^      ^Resize^
----------------------------------------------------------------
_h_ ←         _v_ertical      _b_uffer        _q_ X←
_j_ ↓         _x_ horizontal  _f_ind files    _w_ X↓
_k_ ↑         _z_ undo        _a_ce 1     _e_ X↑
_l_ →         _Z_ reset       _s_wap      _r_ X→
_F_ollow        _D_lt Other     _S_ave      max_i_mize
_SPC_ cancel    _o_nly this     _d_elete"
	      ("h" windmove-left )
	      ("j" windmove-down )
	      ("k" windmove-up )
	      ("l" windmove-right )
	      ("q" hydra-move-splitter-left)
	      ("w" hydra-move-splitter-down)
	      ("e" hydra-move-splitter-up)
	      ("r" hydra-move-splitter-right)
	      ("b" helm-mini)
	      ("f" helm-find-files)
	      ("F" follow-mode)
	      ("a" (lambda ()
		     (interactive)
		     (ace-window 1)
		     (add-hook 'ace-window-end-once-hook
			       'hydra-window/body))
	       )
	      ("v" (lambda ()
		     (interactive)
		     (split-window-right)
		     (windmove-right))
	       )
	      ("x" (lambda ()
		     (interactive)
		     (split-window-below)
		     (windmove-down))
	       )
	      ("s" (lambda ()
		     (interactive)
		     (ace-window 4)
		     (add-hook 'ace-window-end-once-hook
			       'hydra-window/body)))
	      ("S" save-buffer)
	      ("d" delete-window)
	      ("D" (lambda ()
		     (interactive)
		     (ace-window 16)
		     (add-hook 'ace-window-end-once-hook
			       'hydra-window/body))
	       )
	      ("o" delete-other-windows)
	      ("i" ace-maximize-window)
	      ("z" (progn
		     (winner-undo)
		     (setq this-command 'winner-undo))
	       )
	      ("Z" winner-redo)
	      ("SPC" nil))

	    (defhydra hydra-projectile-other-window (:color teal)
	      "projectile-other-window"
	      ("f"  projectile-find-file-other-window        "file")
	      ("g"  projectile-find-file-dwim-other-window   "file dwim")
	      ("d"  projectile-find-dir-other-window         "dir")
	      ("b"  projectile-switch-to-buffer-other-window "buffer")
	      ("q"  nil                                      "cancel" :color blue))

	    (defhydra hydra-projectile (:color teal :hint nil)
	      "
     PROJECTILE: %(projectile-project-root)

     Find File            Search/Tags          Buffers                Cache
------------------------------------------------------------------------------------------
_s-f_: file            _a_: ag                _i_: Ibuffer           _c_: cache clear
 _ff_: file dwim       _g_: update gtags      _b_: switch to buffer  _x_: remove known project
 _fd_: file curr dir   _o_: multi-occur     _s-k_: Kill all buffers  _X_: cleanup non-existing
  _r_: recent file                                               ^^^^_z_: cache current
  _d_: dir"
	      ("a"   projectile-ag)
	      ("b"   projectile-switch-to-buffer)
	      ("c"   projectile-invalidate-cache)
	      ("d"   projectile-find-dir)
	      ("s-f" projectile-find-file)
	      ("ff"  projectile-find-file-dwim)
	      ("fd"  projectile-find-file-in-directory)
	      ("g"   ggtags-update-tags)
	      ("s-g" ggtags-update-tags)
	      ("i"   projectile-ibuffer)
	      ("K"   projectile-kill-buffers)
	      ("s-k" projectile-kill-buffers)
	      ("m"   projectile-multi-occur)
	      ("o"   projectile-multi-occur)
	      ("s-p" projectile-switch-project "switch project")
	      ("p"   projectile-switch-project)
	      ("s"   projectile-switch-project)
	      ("r"   projectile-recentf)
	      ("x"   projectile-remove-known-project)
	      ("X"   projectile-cleanup-known-projects)
	      ("z"   projectile-cache-current-file)
	      ("`"   hydra-projectile-other-window/body "other window")
	      ("q"   nil "cancel" :color blue))

	    (defhydra hydra-learn-sp (:hint nil)
	      "
  _B_ backward-sexp            -----
  _F_ forward-sexp               _s_ splice-sexp
  _L_ backward-down-sexp         _df_ splice-sexp-killing-forward
  _H_ backward-up-sexp           _db_ splice-sexp-killing-backward
^^------                         _da_ splice-sexp-killing-around
  _k_ down-sexp                -----
  _j_ up-sexp                    _C-s_ select-next-thing-exchange
-^^-----                         _C-p_ select-previous-thing
  _n_ next-sexp                  _C-n_ select-next-thing
  _p_ previous-sexp            -----
  _a_ beginning-of-sexp          _C-f_ forward-symbol
  _z_ end-of-sexp                _C-b_ backward-symbol
--^^-                          -----
  _t_ transpose-sexp             _c_ convolute-sexp
-^^--                            _g_ absorb-sexp
  _x_ delete-char                _q_ emit-sexp
  _dw_ kill-word               -----
  _dd_ kill-sexp                 _,b_ extract-before-sexp
-^^--                            _,a_ extract-after-sexp
  _S_ unwrap-sexp              -----
-^^--                            _AP_ add-to-previous-sexp
  _C-h_ forward-slurp-sexp       _AN_ add-to-next-sexp
  _C-l_ forward-barf-sexp      -----
  _C-S-h_ backward-slurp-sexp    _ join-sexp
  _C-S-l_ backward-barf-sexp     _|_ split-sexp
"
	      ;; TODO: Use () and [] - + * | <space>
	      ("B" sp-backward-sexp );; similiar to VIM b
	      ("F" sp-forward-sexp );; similar to VIM f
	      ;;
	      ("L" sp-backward-down-sexp )
	      ("H" sp-backward-up-sexp )
	      ;;
	      ("k" sp-down-sexp ) ; root - towards the root
	      ("j" sp-up-sexp )
	      ;;
	      ("n" sp-next-sexp )
	      ("p" sp-previous-sexp )
	      ;; a..z
	      ("a" sp-beginning-of-sexp )
	      ("z" sp-end-of-sexp )
	      ;;
	      ("t" sp-transpose-sexp )
	      ;;
	      ("x" sp-delete-char )
	      ("dw" sp-kill-word )
	      ;;("ds" sp-kill-symbol ) ;; Prefer kill-sexp
	      ("dd" sp-kill-sexp )
	      ;;("yy" sp-copy-sexp ) ;; Don't like it. Pref visual selection
	      ;;
	      ("S" sp-unwrap-sexp ) ;; Strip!
	      ;;("wh" sp-backward-unwrap-sexp ) ;; Too similar to above
	      ;;
	      ("C-h" sp-forward-slurp-sexp )
	      ("C-l" sp-forward-barf-sexp )
	      ("C-S-h" sp-backward-slurp-sexp )
	      ("C-S-l" sp-backward-barf-sexp )
	      ;;
	      ;;("C-[" (bind (sp-wrap-with-pair "[")) ) ;;FIXME
	      ;;("C-(" (bind (sp-wrap-with-pair "(")) )
	      ;;
	      ("s" sp-splice-sexp )
	      ("df" sp-splice-sexp-killing-forward )
	      ("db" sp-splice-sexp-killing-backward )
	      ("da" sp-splice-sexp-killing-around )
	      ;;
	      ("C-s" sp-select-next-thing-exchange )
	      ("C-p" sp-select-previous-thing )
	      ("C-n" sp-select-next-thing )
	      ;;
	      ("C-f" sp-forward-symbol )
	      ("C-b" sp-backward-symbol )
	      ;;
	      ;;("C-t" sp-prefix-tag-object)
	      ;;("H-p" sp-prefix-pair-object)
	      ("c" sp-convolute-sexp )
	      ("g" sp-absorb-sexp )
	      ("q" sp-emit-sexp )
	      ;;
	      (",b" sp-extract-before-sexp )
	      (",a" sp-extract-after-sexp )
	      ;;
	      ("AP" sp-add-to-previous-sexp );; Difference to slurp?
	      ("AN" sp-add-to-next-sexp )
	      ;;
	      ("_" sp-join-sexp ) ;;Good
	      ("|" sp-split-sexp ))


	    (global-set-key (kbd "C-c m") 'hydra-move/body)
	    (global-set-key (kbd "C-c t r") 'hydra-transpose/body)
	    (global-set-key (kbd "C-c w") 'hydra-window/body)
	    (global-set-key (kbd "C-c O") 'hydra-projectile-other-window/body)
	    (global-set-key (kbd "C-c P") 'hydra-projectile/body)
	    (global-set-key (kbd "C-c S") 'hydra-learn-sp/body)
	    (global-set-key (kbd "C-c g") 'hydra-goto/body)))

(provide 'sunra-baseline-packages)
