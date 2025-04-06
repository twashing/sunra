(require 'package)


(setq emacs-dir (file-name-directory
		 (or (buffer-file-name)
		     (file-chase-links load-file-name))))

(dolist (pkg '("packages" "packages/llm"))
  (add-to-list 'load-path (concat emacs-dir pkg)))

(defmacro use-packages (&rest args)
  `(progn
     ,@(mapcar (lambda (pkg)
                 `(require ,pkg ,@(cdr args)))
               (car args))))

(use-packages ('sunra-base
	             'sunra-core
	             'sunra-desktop
	             'sunra-keybinds
	             'sunra-navigation
	             'sunra-llm
	             'sunra-multiple-cursors
	             'sunra-speech
	             'sunra-windows
	             'sunra-markdown
	             'sunra-vc
               'sunra-projects))


;; TODO - Problem
;; In the example, we see here highlighting this form and pressing tab, aligns all of its list elements vertically.
;; (use-packages ('sunra-base
;; 	             'sunra-core
;; 	             'sunra-desktop
;; 	             'sunra-keybinds
;; 	             'sunra-navigation
;; 	             'sunra-llm
;; 	             'sunra-multiple-cursors
;; 	             'sunra-speech
;; 	             'sunra-windows
;; 	             'sunra-markdown
;; 	             'sunra-vc))
;; 
;; However, given the example in packages/llm/gptel/tools/tools-base.el,
;; highlighting the gptel-make-tool form and pressing tab, misaligns all of the list elements in :args like so.
;; (gptel-make-tool :name "echo_message"
;;                  :description "Send a message to the *Messages* buffer"
;; 
;;                  :function (lambda (text)
;;                              (message "%s" text)
;;                              (format "Message sent: %s" text))
;;                  :args (list '(:name "text"
;; 				                             :type "string"
;; 				                             :description "The text to send to the messages buffer"))
;;                  :category "emacs")
;; 
;; What is the configuration doing this?
;; And provide a clear and concise configuration to align elements vertically like in B, instead of the existing pattern in A.
;; 
;; '(:name "query"
;;  	  :type "string"
;;  	  :description "Parameter for query")
;; 
;; '(:name "query"
;;   :type "string"
;;   :description "Parameter for query")


;; Solution
;; Looking at your code snippets, I can see the difference in indentation between your two examples. The issue is likely with how Emacs is configured to indent list elements in Emacs Lisp mode.
;; 
;; The indentation in Emacs is controlled by various settings, and for Lisp-like languages, the indentation is often determined by special rules for known functions and macros.
;; 
;; The issue is that `gptel-make-tool` is likely not recognized with proper indentation rules, especially for the property lists inside the `:args` parameter.
;; 
;; To fix this, you can add custom indentation rules for `gptel-make-tool` and property lists. Here's a configuration that should help align these elements vertically:
;; 
;; ```elisp
;; ;; Add proper indentation for gptel-make-tool
;; (put 'gptel-make-tool 'lisp-indent-function 1)
;; 
;; ;; Improve property list indentation
;; (defun sunra-lisp-indent-function (indent-point state)
;;   (let ((normal-indent (current-column)))
;;     (goto-char (1+ (elt state 1)))
;;     (parse-partial-sexp (point) calculate-lisp-indent-last-sexp 0 t)
;;     (if (and (elt state 2)
;;              (not (looking-at "\\sw\\|\\s_")))
;;         ;; car of form doesn't seem to be a symbol
;;         (progn
;;           (if (not (> (save-excursion (forward-line 1) (point))
;;                       calculate-lisp-indent-last-sexp))
;;               (progn (goto-char calculate-lisp-indent-last-sexp)
;;                      (beginning-of-line)
;;                      (parse-partial-sexp (point)
;;                                          calculate-lisp-indent-last-sexp 0 t)))
;;           ;; Indent under the list or under the first sexp on the same
;;           ;; line as calculate-lisp-indent-last-sexp.  Note that first
;;           ;; thing on that line has to be complete sexp since we are
;;           ;; inside the innermost containing sexp.
;;           (backward-prefix-chars)
;;           (current-column))
;;       (let ((function (buffer-substring (point)
;;                                         (progn (forward-sexp 1) (point))))
;;             method)
;;         (setq method (or (function-get (intern-soft function)
;;                                         'lisp-indent-function)
;;                          (get (intern-soft function) 'lisp-indent-hook)))
;;         (cond ((or (eq method 'defun)
;;                    (and (null method)
;;                         (> (length function) 3)
;;                         (string-match "\\`def" function)))
;;                (lisp-indent-defform state indent-point))
;;               ((and (null method)
;;                     (> (length function) 1)
;;                     (string-match "\\`:" function))
;;                ;; This is a property list - indent it properly
;;                (let ((base-column (current-column)))
;;                  (forward-line 1)
;;                  (if (< (point) indent-point)
;;                      (+ base-column lisp-body-indent)
;;                    normal-indent)))
;;               ((integerp method)
;;                (lisp-indent-specform method state
;;                                      indent-point normal-indent))
;;               (method
;;                (funcall method indent-point state)))))))
;; 
;; (setq lisp-indent-function 'sunra-lisp-indent-function)
;; ```
;; 
;; Add this to your Emacs configuration file. This will:
;; 1. Set proper indentation for `gptel-make-tool` function
;; 2. Improve property list indentation by recognizing keywords starting with `:` and indenting them properly
;; 
;; This should ensure that your property lists inside `:args` are properly aligned vertically as in your desired example.
