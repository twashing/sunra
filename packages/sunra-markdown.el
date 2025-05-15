;;; sunra-markdown.el --- Markdown configuration with pandoc support -*- lexical-binding: t -*-


;; Emacs markdown-mode 
;; https://jblevins.org/projects/markdown-mode
;; 
;; Configure to run previews using Pandoc.
;; use-package conditionally installs Pandoc, if it's not already on the host system.
;; https://pandoc.org
;; https://github.com/jgm/pandoc
;; https://pandoc.org/getting-started.html
;; https://pandoc.org/installing.html
;; https://gist.github.com/briandk/a64c81a3342717f10aab (Installing Pandoc on Mac)

(defun sunra-ensure-pandoc-installed ()
  "Check if pandoc is installed, and install it if not."
  (unless (executable-find "pandoc")
    (cond
     ((eq system-type 'darwin)
      (message "Installing pandoc via Homebrew...")
      (shell-command "brew install pandoc"))
     ((eq system-type 'gnu/linux)
      (when (executable-find "apt-get")
        (message "Installing pandoc via apt...")
        (shell-command "sudo apt-get install -y pandoc")))
     ((eq system-type 'windows-nt)
      (message "Please install pandoc manually from https://pandoc.org/installing.html"))
     (t
      (message "Please install pandoc manually from https://pandoc.org/installing.html")))))

(use-package markdown-mode

  :ensure t
  :defer t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init
  ;; Check for pandoc when markdown-mode is loaded
  (add-hook 'markdown-mode-hook #'sunra-ensure-pandoc-installed)
  
  :config
  ;; Configure markdown-mode to use pandoc for previews
  (setq markdown-command "pandoc -f markdown -t html")
  
  ;; Additional configuration
  (setq markdown-fontify-code-blocks-natively t)
  (setq markdown-enable-math t)
  (setq markdown-header-scaling t)
  
  ;; Live preview settings
  (setq markdown-live-preview-delete-export 'delete-on-export)
  (setq markdown-live-preview-window-function 'markdown-live-preview-window-eww))

(provide 'sunra-markdown)
