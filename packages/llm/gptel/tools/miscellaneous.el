
;; NOTE
;; Taken from https://github.com/lem102/.emacs.d/blob/master/init.el
(gptel-make-tool :name "variable_completions"
                 :function (lambda (query)
                             (let (symbols)
                               (mapatoms (lambda (symbol)
                                           (let ((name (symbol-name symbol)))
                                             (when (and (boundp symbol)
                                                        (string-match-p query name))
                                               (push symbol symbols)))))
                               symbols))
                 :description "get the names of all the variables that match the search query"
                 :args (list '( :name "search query"
                                :type string
                                :description "the search query"))
                 :category "emacs")

(gptel-make-tool :name "function_completions"
                 :function (lambda (query)
                             (let (symbols)
                               (mapatoms (lambda (symbol)
                                           (let ((name (symbol-name symbol)))
                                             (when (and (fboundp symbol)
                                                        (string-match-p query name))
                                               (push symbol symbols)))))
                               symbols))
                 :description "get the names of all the functions that match the search query"
                 :args (list '( :name "search query"
                                :type string
                                :description "the search query"))
                 :category "emacs")

(gptel-make-tool :name "command_completions"
                 :function (lambda (query)
                             (let (symbols)
                               (mapatoms (lambda (symbol)
                                           (let ((name (symbol-name symbol)))
                                             (when (and (commandp symbol)
                                                        (string-match-p query name))
                                               (push symbol symbols)))))
                               symbols))
                 :description "get the names of all the commands that match the search query"
                 :args (list '( :name "search query"
                                :type string
                                :description "the search query"))
                 :category "emacs")

(gptel-make-tool :name "variable_documentation"
                 :function (lambda (variable-name)
                             (let ((symbol (intern-soft variable-name)))
                               (when (and symbol (boundp symbol))
                                 (documentation-property symbol
                                                         'variable-documentation))))
                 :description "get the documentation for an emacs variable"
                 :args (list '( :name "variable name"
                                :type string
                                :description "the variable name"))
                 :category "emacs")

(gptel-make-tool :name "function_documentation"
                 :function (lambda (function-name)
                             (let ((symbol (intern-soft function-name)))
                               (when (and symbol (fboundp symbol))
                                 (documentation symbol))))
                 :description "get the documentation for an emacs function"
                 :args (list '( :name "function name"
                                :type string
                                :description "the function name"))
                 :category "emacs")

(gptel-make-tool :name "variable_value"
                 :function (lambda (variable-name)
                             (let ((symbol (intern-soft variable-name)))
                               (when (and symbol (boundp symbol))
                                 (symbol-value symbol))))
                 :description "get the value of an emacs variable"
                 :args (list '( :name "variable name"
                                :type string
                                :description "the variable's name"))
                 :category "emacs")

(gptel-make-tool :name "variable_source"
                 :function (lambda (variable-name)
                             (let ((symbol (intern-soft variable-name)))
                               (when (and symbol (boundp symbol))
                                 (with-temp-buffer
                                   (find-variable symbol)
                                   (buffer-substring-no-properties (point)
                                                                   (save-excursion
                                                                     (end-of-defun)
                                                                     (point)))))))
                 :description "get the source code of an emacs variable"
                 :args (list '( :name "variable name"
                                :type string
                                :description "the variable's name"))
                 :category "emacs")

(defun jacob-gptel-function-source (function-name)
  "Get the source code of an Emacs function called FUNCTION-NAME."
  (let ((symbol (intern-soft function-name)))
    (when (and symbol (fboundp symbol))
      (save-window-excursion
        (find-function symbol)
        (buffer-substring-no-properties (point)
                                        (save-excursion
                                          (end-of-defun)
                                          (point)))))))

(gptel-make-tool :name "function_source"
                 :function #'jacob-gptel-function-source
                 :description "get the source code of an emacs function"
                 :args (list '( :name "function name"
                                :type string
                                :description "the function's name"))
                 :category "emacs")

(defun jacob-gptel-symbol-manual-section (symbol-name)
  "Get the manual node for SYMBOL-NAME."
  (when-let ((symbol (intern-soft symbol-name)))
    (save-window-excursion
      (info-lookup-symbol symbol)
      (buffer-string))))

(gptel-make-tool :name "symbol_manual_section"
                 :function #'jacob-gptel-symbol-manual-section
                 :description "get the manual page of an emacs symbol"
                 :args (list '( :name "manual page name"
                                :type string
                                :description "the name of the manual page"))
                 :category "emacs")

(defun jacob-gptel-library-source (library-name)
  "Get the source code of LIBRARY-NAME."
  (when (locate-library library-name)
    (save-window-excursion
      (find-library library-name)
      (buffer-string))))

(gptel-make-tool :name "library_source"
                 :function #'jacob-gptel-library-source
                 :description "get the source code of a library or package in emacs"
                 :args (list '( :name "library name"
                                :type string
                                :description "the library name"))
                 :category "emacs")

(defun jacob-gptel-manual-node-contents (node-name)
  "Get the contents of the manul node NODE-NAME."
  (save-window-excursion
    (Info-goto-node node-name)
    (buffer-string)))

(gptel-make-tool :name "manual_node_contents"
                 :function #'jacob-gptel-manual-node-contents
                 :description "get the contents of the manual node."
                 :args (list '( :name "manual node name"
                                :type string
                                :description "the manual node's name"))
                 :category "emacs")


;; NOTE
;; Taken from https://github.com/jonmoore/JMEmacs/blob/master/lisp/jm-gptel-tools.el

;;;###autoload
(defun gptel-describe-tools ()
  "Display a buffer containing summary information about the known GPTel tools."
  (interactive)
  (let ((buffer (get-buffer-create "*GPTel Tools*")))
    (with-current-buffer buffer
      (erase-buffer)
      (insert (format "%-20s %-20s %-80s\n" "Category" "Tool Name" "Description"))
      (insert (make-string 120 ?=) "\n")
      (dolist (category-tools gptel--known-tools)
        (let ((category (car category-tools))
              (tools (cdr category-tools)))
          (dolist (tool-pair tools)
            (let ((tool (cdr tool-pair)))
              (insert (format "%-20s %-20s %-80s\n"
                              category
                              (gptel-tool-name tool)
                              (gptel-tool-description tool)))))))
      (goto-char (point-min)))
    (display-buffer buffer)))

(defun jm-gptel-describe-function-for-llm (function)
  "Describe FUNCTION for further processing by an LLM.
Return the text collected from running `describe-function' and
the function code itself (found via `find-function') as a single string."
  (let (description function-code)
    (save-excursion
      ;; Capture the output of describe-function
      (describe-function function)
      (with-current-buffer "*Help*"
        (setq description (buffer-substring-no-properties (point-min) (point-max))))

      ;; Find the function and copy its text to function-code
      (when-let ((location (find-function-noselect function)))
        (with-current-buffer (car location)
          (let ((start (cdr location)))
            (goto-char start)
            (end-of-defun)
            (setq function-code (buffer-substring-no-properties start (point)))))))

    (concat description "\n"
            "Its code is below:\n\n"
            function-code)))

(defun jm-gptel-prompt-to-request-tool (function)
  "Return a prompt to request creating code which calls
`gptel-make-tool' to make a tool that wraps FUNCTION, assumed to
be an elisp function discoverable via `find-function'"
  (let (here-is-example)

    ;; Hard-code the example here because I don't have a way yet to
    ;; encode the call to gptel-make-tool.
    ;;
    ;; TODO: maybe just use the docs / code from gptel-make-tool
    (setq here-is-example
          "Here is an example of how to convert a function jm--gptel-tools-read-url into
a tool for emacs gptel library that can be used with an OpenAI API.

(defun jm--gptel-tools-read-url (url)
  \"Fetch and read the contents of a URL.\"
  (with-current-buffer (url-retrieve-synchronously url)
    (goto-char (point-min))
    (forward-paragraph)
    (let ((dom (libxml-parse-html-region (point) (point-max))))
      (run-at-time 0 nil #'kill-buffer (current-buffer))
      (with-temp-buffer
        (shr-insert-document dom)
        (buffer-substring-no-properties (point-min) (point-max))))))

(gptel-make-tool
 :function #'jm--gptel-tools-read-url
 :name \"read_url\"
 :description \"Fetch and read the contents of a URL\"
 :args (list '(:name \"url\" :type \"string\" :description \"The URL to read\"))
 :category \"web\")

"
          )
    (setq gptel-make-tool-description
          (jm-gptel-describe-function-for-llm 'gptel-make-tool)

          )
    (concat here-is-example
            "\nBelow is information on gptel-make-tool\n"
            gptel-make-tool-description
            "\nBelow is information on another function " (symbol-name function) "\n"
            (jm-gptel-describe-function-for-llm function)
            "\nWrite a tool using gptel-make-tool that wraps " (symbol-name function)
            "\nJust return the code to call gptel-make-tool.  Do not escape it with back quotes or provide example code"


            )))

(defun jm-gptel-make-wrapper-tool-call (function)
  "Use gptel to insert code at point that should call
`gptel-make-tool' to create a tool that wraps FUNCTION. FUNCTION
is assumed to be an elisp function discoverable via
‘find-function’.

Example call:

(jm-gptel-make-wrapper-tool-call 'number-sequence)
"
  (gptel-request
      (jm-gptel-prompt-to-request-tool function)))

(defun jm--gptel-tools-search-emacs-documentation (pattern)
  "Search the Emacs documentation for a given PATTERN, call apropos
and return its summary buffer contents as a string.

Example:
  (jm--gptel-tools-search-emacs-documentation \"find-file\")"
  ;; The advice here provides the same argument-preprocessing as calling apropos
  ;; interactively.  It's extracted from apropos-read-pattern, which apropos uses, but
  ;; using the pattern argument rather prompting the user for a text input.  Ideally we'd
  ;; have a generic mechanism to call a function as if the user provided that exact input.

  ;; Aside on LLMs: I asked both gpt-o4 and web versions of Gemini to generate this tool.
  ;; Their attempts had the right structure but I ended up writing the non-trivial bits
  ;; below (for argument processing and window management).  That was the bulk of the
  ;; work, i.e. it took more time than I would have needed to create the skeleton from
  ;; scratch.  Even with that I don't think this is at the standard an Emacs expert would
  ;; implement, e.g. I suspect there's are ways to (1) generically use the interactive
  ;; buffer preprocessing rather than copy-pasting from apropos-read-pattern and (2) stop
  ;; the *Apropos* window being created rather than deleting it after apropos creates it.
  (let ((advice-id (advice-add 'apropos-read-pattern :override
                               (lambda (&rest args)
                                 (if (string-equal (regexp-quote pattern) pattern)
                                     (or (split-string pattern "[ \t]+" t)
                                         (user-error "No word list given"))
                                   pattern)))))
    (call-interactively 'apropos)
    (advice-remove 'apropos-read-pattern advice-id)
    ;; apropos displays the *Apropos* buffer in a window but doesn't return the contents.
    ;; below we kill the window and return the buffer contents for use by the LLM.
    (let* ((apropos-buffer (get-buffer "*Apropos*"))
           (apropos-contents (with-current-buffer apropos-buffer (buffer-string)))
           (apropos-window (get-buffer-window apropos-buffer)))
      (when apropos-window (delete-window apropos-window))
      apropos-contents)))

(gptel-make-tool :name "search_emacs_docs"
                 :description "Search the Emacs documentation for a given keyword or topic"
                 :function #'jm--gptel-tools-search-emacs-documentation
                 :args (list '(:name "pattern" :type "string" :description "The keyword or topic to search for in the Emacs documentation."))
                 :category "emacs")


;; NOTE
;; Taken from https://github.com/skissue/dotfiles/blob/main/home/emacs/config.el
(gptel-make-tool :name "clone_repository"
                 :description "Clone a Git repository"

                 :args (list '(:name "repo_uri"
                               :type "string"
                               :description "The URI of the Git repository to clone"))
                 :category "Programming"
                 :confirm t
                 :function (lambda (repo-uri)
                             (let* ((repo-name (file-name-nondirectory
                                                (string-trim-right repo-uri "\\.git")))
                                    (target-dir (expand-file-name repo-name "~/git")))
                               (if (file-exists-p target-dir)
                                   (error "Directory already exists: %s" target-dir)
                                 (unless (zerop (call-process "git" nil nil nil
                                                              "clone" repo-uri target-dir))
                                   (error "Failed to clone repository"))
                                 (format "Repository cloned successfully: %s" target-dir)))))
