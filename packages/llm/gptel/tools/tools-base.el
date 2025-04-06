;;; ../Projects/dotfiles/.doom.d/gptel/tools/tools.el -*- lexical-binding: t; -*-


(gptel-make-tool :name "echo_message"
                 :description "Send a message to the *Messages* buffer"

                 :function (lambda (text)
                             (message "%s" text)
                             (format "Message sent: %s" text))
                 :args (list '(:name "text"
                               :type "string"
                               :description "The text to send to the messages buffer"))
                 :category "emacs")

(gptel-make-tool :name "read_url"
                 :description "Fetch and read the contents of a URL"

                 :function (lambda (url)
                             (with-current-buffer (url-retrieve-synchronously url)
                               (goto-char (point-min)) (forward-paragraph)
                               (let ((dom (libxml-parse-html-region (point) (point-max))))
                                 (run-at-time 0 nil #'kill-buffer (current-buffer))
                                 (with-temp-buffer
                                   (shr-insert-document dom)
                                   (buffer-substring-no-properties (point-min) (point-max))))))
                 :args (list '(:name "url"
                               :type "string"
                               :description "The URL to read"))
                 :category "web")

(gptel-make-tool :name "read_buffer"
                 :description "Return the contents of an Emacs buffer"

                 :function (lambda (buffer)
                             (unless (buffer-live-p (get-buffer buffer))
                               (error "Error: buffer %s is not live." buffer))
                             (with-current-buffer  buffer
                               (buffer-substring-no-properties (point-min) (point-max))))
                 :args (list '(:name "buffer"
                               :type "string"
                               :description "The name of the buffer whose contents are to be retrieved"))
                 :category "emacs")

(gptel-make-tool :name "append_to_buffer"
                 :description "Append text to the an Emacs buffer.  If the buffer does not exist, it will be created."

                 :function (lambda (buffer text)
                             (with-current-buffer (get-buffer-create buffer)
                               (save-excursion
                                 (goto-char (point-max))
                                 (insert text)))
                             (format "Appended text to buffer %s" buffer))
                 :args (list '(:name "buffer"
                               :type "string"
                               :description "The name of the buffer to append text to.")
                             '(:name "text"
                               :type "string"
                               :description "The text to append to the buffer."))
                 :category "emacs")

(gptel-make-tool :name "list_directory"
                 :description "List the contents of a given directory"

                 :function (lambda (directory)
	                     (mapconcat #'identity
                                        (directory-files directory)
                                        "\n"))
                 :args (list '(:name "directory"
	                       :type "string"
	                       :description "The path to the directory to list"))
                 :category "filesystem")

(gptel-make-tool :name "make_directory"
                 :description "Create a new directory with the given name in the specified parent directory"

                 :function (lambda (parent name)
                             (condition-case nil
                                 (progn
                                   (make-directory (expand-file-name name parent) t)
                                   (format "Directory %s created/verified in %s" name parent))
                               (error (format "Error creating directory %s in %s" name parent))))
                 :args (list '(:name "parent"
	                       :type "string"
	                       :description "The parent directory where the new directory should be created, e.g. /tmp")
                             '(:name "name"
	                       :type "string"
	                       :description "The name of the new directory to create, e.g. testdir"))
                 :category "filesystem")

(gptel-make-tool :name "create_file"
                 :description "Create a new file with the specified content"

                 :function (lambda (path filename content)
                             (let ((full-path (expand-file-name filename path)))
                               (with-temp-buffer
                                 (insert content)
                                 (write-file full-path))
                               (format "Created file %s in %s" filename path)))
                 :args (list '(:name "path"
	                       :type "string"
	                       :description "The directory where to create the file")
                             '(:name "filename"
	                       :type "string"
	                       :description "The name of the file to create")
                             '(:name "content"
	                       :type "string"
	                       :description "The content to write to the file"))
                 :category "filesystem")

(gptel-make-tool :name "read_file"
                 :description "Read and display the contents of a file"

                 :function (lambda (filepath)
	                     (with-temp-buffer
	                       (insert-file-contents (expand-file-name filepath))
	                       (buffer-string)))
                 :args (list '(:name "filepath"
	                       :type "string"
	                       :description "Path to the file to read.  Supports relative paths and ~."))
                 :category "filesystem")

(gptel-make-tool :name "screenshot"
                 :description "Take a screenshot and save it to a file."

                 :function #'screenshot
                 :args (list '(:name "emacs-frame-only"
                               :type "string"
                               :description "Parameter for emacs-frame-only"))
                 :category "desktop")

(gptel-make-tool :name "screencapture"
                 :description "Record the screen with SCREEN-ID for DURATION seconds using ffmpeg’s avfoundation input."

                 :function #'screencapture
                 :args (list '(:name "screen-id"
                               :type "string"
                               :description "Parameter for screen-id")
                             '(:name "duration"
                               :type "string"
                               :description "Parameter for duration"))
                 :category "desktop")

(defun generate_llm_tool (function-name category)

  (let* ((func-symbol (intern-soft function-name))
         (result "")
         (error-msg nil))

    ;; Check if function exists and is callable
    (cond
     ((not func-symbol)
      (setq error-msg (format "Function '%s' not found" function-name)))

     ((not (fboundp func-symbol))
      (setq error-msg (format "'%s' is not a function" function-name)))

     (t
      (let* ((arglist (help-function-arglist func-symbol t))
             (doc (or (documentation func-symbol) "No documentation available"))
             (first-line-of-doc (car (split-string doc "\n")))
             ;; Filter out &optional, &rest markers from arglist
             (clean-args (seq-filter (lambda (arg)
                                       (and (symbolp arg)
                                            (not (string-prefix-p "&" (symbol-name arg)))))
                                     arglist))
             (arg-descriptors
              (mapcar (lambda (arg)
                        (format "(:name \"%s\"\n                 :type \"string\"\n                 :description \"Parameter for %s\")"
                                (symbol-name arg) (symbol-name arg)))
                      clean-args)))

        ;; Build the gptel-make-tool definition
        (setq result
              (format "(gptel-make-tool :name \"%s\"\n                 :description \"%s\"\n\n                 :function #'%s\n                 :args (list %s)\n                 :category \"%s\")"
                      function-name
                      (replace-regexp-in-string "\"" "\\\\\"" first-line-of-doc)
                      function-name
                      (if arg-descriptors
                          (mapconcat #'identity arg-descriptors "\n                        ")
                        "nil")
                      category)))))

    ;; Return error or result
    (or error-msg result)))

(gptel-make-tool :name "generate_llm_tool"
 :description "Generate a gptel-make-tool definition from an existing Elisp function. This examines the function's signature, arguments, and docstring to create a tool that can be used by LLMs."

 :function #'generate_llm_tool

 :args (list '(:name "function-name"
               :type "string"
               :description "Name of the Elisp function to convert into a gptel tool")
             '(:name "category"
               :type "string"
               :description "Category for the generated tool (e.g., 'emacs', 'filesystem', etc.)"))
 :category "development")
