(defun sunra/new-buffer ()
  (interactive)
  (let ((buffer (generate-new-buffer "*new*")))
    (set-window-buffer nil buffer)
    (with-current-buffer buffer
      (funcall (default-value 'major-mode)))))

(defmacro sunra/setq! (&rest settings)
  "A more sensible `setopt' for setting customizable variables.

   This can be used as a drop-in replacement for `setq' and *should* be used
   instead of `setopt'. Unlike `setq', this triggers custom setters on variables.
   Unlike `setopt', this won't needlessly pull in dependencies."

  (macroexp-progn
   (cl-loop for (var val) on settings by 'cddr
            collect `(funcall (or (get ',var 'custom-set) #'set-default-toplevel-value)
                              ',var ,val))))

(defmacro sunra/dir! (&optional path)
  "Return the directory of the file in which this macro is expanded.
   If PATH is non-nil, return its full path relative to that directory.
   For example, (dir! \"+git\") returns the full path to \"+git.el\" in the current file's directory."

  (let ((current-file (or load-file-name buffer-file-name)))
    (if current-file
        `(file-name-as-directory
          (expand-file-name ,(or path "") (file-name-directory ,current-file)))
      (error "Cannot determine directory: no load-file-name or buffer-file-name"))))

(defun sunra/load! (file &optional noerror)
  "Load the Emacs Lisp FILE relative to the file this function is called from.
   Omit the file extension to allow Emacs to load the byte-compiled version if available.
   For example, (load! \"+git\") loads the file \"+git.el\" in the same directory."

  (let ((target (expand-file-name file (file-name-directory (or load-file-name buffer-file-name)))))
    (load target noerror)))

(provide 'sunra-core)
