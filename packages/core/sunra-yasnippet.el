(defhydra hydra-yasnippet (:color blue :hint nil)
			        "
              ^YASnippets^
--------------------------------------------
  Modes:    Load/Visit:    Actions:

 _g_lobal  _d_irectory    _i_nsert
 _m_inor   _f_ile         _t_ryout
 _e_xtra   _l_ist         _n_ew
         _a_ll
"
				("d" yas-load-directory)
				("e" yas-activate-extra-mode)
				("i" yas-insert-snippet)
				("f" yas-visit-snippet-file :color blue)
				("n" yas-new-snippet)
				("t" yas-tryout-snippet)
				("l" yas-describe-tables)
				("g" yas/global-mode)
				("m" yas/minor-mode)
				("a" yas-reload-all))

(use-package yasnippet
  :ensure nil
  :bind ("C-c Y" . hydra-yasnippet/body)
  :init (progn
	  (if (not (file-exists-p "~/.emacs.d/snippets"))
	      (make-directory "~/.emacs.d/snippets")))
  :config (progn
	    (yas-global-mode 1)
	    (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
	    (yas-load-directory "~/.emacs.d/snippets")))

(provide 'sunra-yasnippet)
