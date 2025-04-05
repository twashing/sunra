
(defun apply-template (template-file output-file &optional context)
  "Apply a template file TEMPLATE-FILE and write the result to OUTPUT-FILE.
   Replaces placeholders of the form:
   - {file:FILENAME} with the contents of FILENAME (resolved relative to TEMPLATE-FILE's directory)
   - {var:VARNAME} with the value associated with VARNAME in CONTEXT (an alist), or an empty string if CONTEXT is nil.

   Example usage:
   Assuming your project directory contains:
   - \"Content.md\" with contents: \"Bar\"
   - \"A.md.tmpl\" with contents:
        Foo {file:Content.md}
        {var:thing}

   And you want to create \"A.md\" with the inserted text.
   You can call with or without a context of variables

   (apply-template \"path/to/project-directory/A.md.tmpl\"
                   \"path/to/project-directory/A.md\"
                   '((\"thing\" . \"querty\")))

   (apply-template \"path/to/project-directory/A.md.tmpl\"
                   \"path/to/project-directory/A.md\")"

  (let ((project-dir (file-name-directory template-file)))

    (with-temp-buffer

      ;; Read template into a string.
      (insert-file-contents template-file)
      (let ((template (buffer-string)))

        ;; Replace {file:...} placeholders.
        (setq template
              (replace-regexp-in-string
               "{file:\\([^}]+\\)}"
               (lambda (match)
                 ;; Obtain the file name from the match.
                 (let* ((raw-filename (match-string 1 match))
                        ;; Remove any extraneous escape characters if needed.
                        (filename (replace-regexp-in-string "\\\\" "" raw-filename))
                        (full-path (expand-file-name filename project-dir)))
                   (with-temp-buffer
                     (condition-case err
                         (progn
                           (insert-file-contents full-path)
                           (buffer-string))
                       (error (format "[Error reading file: %s]" full-path))))))
               template t t))

        ;; Replace {var:...} placeholders.
        (setq template
              (replace-regexp-in-string
               "{var:\\([^}]+\\)}"
               (lambda (match)
                 (if (string-match "{var:\\([^}]+\\)}" match)
                     (if context
                         (or (cdr (assoc (match-string 1 match) context)) "")
                       "")
                   match))
               template t t))

        ;; Write the resulting string to OUTPUT-FILE.
        (with-temp-file output-file
          (insert template))))))

(defun apply-templates (dir &optional context)
  "Process all .tmpl files in DIR.
   For each file with a .tmpl suffix, create an output file by removing the .tmpl suffix.
   If CONTEXT (an alist) is provided, it is passed to `apply-template` for variable substitutions.

   Example usage:
   Suppose you have a directory \"path/to/project-directory\" with:
     - \"A.md.tmpl\"
     - \"main.c.tmpl\"
   And you want to process these templates with a context:

   (apply-templates \"gptel/directives\"
                    '((\"thing\" . \"querty\")))"

  (dolist (tmpl-file (directory-files dir t "\\.tmpl$"))

    (when (file-regular-p tmpl-file)
      (let* ((output-file (replace-regexp-in-string "\\.tmpl$" "" tmpl-file)))
        (apply-template tmpl-file output-file context)
        (message "Processed template: %s -> %s" tmpl-file output-file)))))

(defun load-gptel-directives (dir)
  "Load all directive files from DIR into gptel-directives.
   Newer directives override existing ones with the same key."
  (let* ((files (directory-files dir t "\\.md$"))
         (new-pairs (mapcar (lambda (file)
                              (cons
                               (intern (file-name-base file))
                               (with-temp-buffer
                                 (insert-file-contents file)
                                 (buffer-string))))
                            files))
         (existing-keys (mapcar #'car gptel-directives))
         (filtered-old (cl-remove-if (lambda (pair)
                                       (member (car pair) (mapcar #'car new-pairs)))
                                     gptel-directives)))
    (setq gptel-directives
          (append new-pairs filtered-old))))

(defun load-all! (dir)
  "Load all .el files from DIR"
  (dolist (file (directory-files dir t "\\.el$"))
    (sunra/load! file)))

(use-package gptel

  :ensure t

  ;; ;; Emacs 30
  ;; :vc (:url "https://github.com/karthink/gptel"
  ;; 	    :branch "feature-tool-use")

  ;; Emacs 29
  :straight (gptel :type git
                   :host github
                   :repo "karthink/gptel"
                   :branch "feature-tool-use")

  :bind ("C-M-'" . gptel-send)

  :init

  (sunra/load! "openapi-key.el")
  (sunra/load! "gemini-key.el")
  (sunra/load! "anthropic-key.el")
  (sunra/load! "linkup-api-key.el")

  :config

  (apply-templates (file-name-concat (sunra/dir!) "gptel/directives"))
  (load-gptel-directives (file-name-concat (sunra/dir!) "gptel/directives"))
  (load-all! (file-name-concat (sunra/dir!) "gptel/tools/"))

  (sunra/setq! gptel-api-key openapi-key
               gptel-expert-commands t
               gptel-prompt-prefix-alist '((markdown-mode . "*Prompt* ")
					   (org-mode . "*Prompt* ")
					   (text-mode . "*Prompt*  "))
               gptel-response-prefix-alist '((markdown-mode . "*Response* ")
					     (org-mode . "*Response* ")
					     (text-mode . "*Response* ")))

  ;; :key can be a function that returns the API key.
  ;; Any name you want
  ;; Streaming responses
  (gptel-make-gemini "Gemini"
		     :key gemini-key
		     :stream t)
  (gptel-make-anthropic "Claude"
			:key anthropic-key
			:stream t)

  ;; NOTE keep this until moving back to `main' branch
  (setq gptel--anthropic-models
        (cons '(claude-3-7-sonnet-20250219
                :description "Hybrid model capable of standard thinking and extended thinking modes"
                :capabilities (media tool-use cache)
                :mime-types ("image/jpeg" "image/png" "image/gif" "image/webp" "application/pdf")
                :context-window 200
                :input-cost 3
                :output-cost 15
                :cutoff-date "2025-02")
              gptel--anthropic-models)))

;; ;; Make sure Git is found
;; (setq straight-vc-git-executable (executable-find "git"))
;; 
;; ;; Show more debugging info
;; (setq straight-verbose t)

(use-package gptel-quick

  :ensure t

  ;; ;; Emacs 30
  ;; :vc (:url "https://github.com/karthink/gptel-quick"
  ;;      :branch "main")

  ;; Emacs 29
  :straight (gptel-quick :type git
			 :host github
			 :repo "karthink/gptel-quick"
			 ;; :branch "main"
			 ;; :fork nil
			 )

  ;; TODO
  ;; :bind (:map embark-general-map
  ;;             ("?" . #'gptel-quick))
  )

(provide 'sunra-llm)
