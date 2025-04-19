

;; # Problem
;; When errors occur in Emacs, it often creates windows displaying `*Warnings*` and `*Backtrace*` buffers.
;; These interruptions can disrupt your workflow, requiring manual intervention to close them.
;; 
;; 
;; # Window fundamentals
;; Emacs' windowing system operates on these key concepts:
;; - *Windows*: Viewports that display buffer content
;; - *Buffers*: Containers for content (text, code, etc.)
;; - *Frames*: The GUI windows that contain multiple Emacs windows
;; When error conditions occur, Emacs creates new windows displaying special buffers like `*Warnings*` and `*Backtrace*`.
;; 
;; 
;; # Solution
;; This is a configuration that binds `C-g` to close these error windows
;; 
;; ## Function breakdown
;; The solution leverages these key functions:
;; 
;; 1. ~get-buffer-window~ - Finds the window displaying a specific buffer, returning nil if none exists
;;    ```elisp
;;    (get-buffer-window "*Warnings*")
;;    ```
;; 
;; 2. ~quit-window~ - Quits a window, with two parameters:
;;    - First argument: Kill buffer if non-nil
;;    - Second argument: The window to quit
;;    ```elisp
;;    (quit-window nil warning-window)
;;    ```
;; 
;; 3. ~keyboard-quit~ - The standard function bound to C-g that cancels operations
;;    ```elisp
;;    (keyboard-quit)
;;    ```
;; 
;; ## Control flow
;; The solution works by:
;; 1. Creating a function that identifies and closes error windows
;; 2. Creating a wrapper function that calls both our custom function and the standard ~keyboard-quit~
;; 3. Rebinding C-g to our new wrapper function
;; 
;; This preserves the standard behavior of C-g while adding window management capabilities.
;; The solution is elegant because it doesn't interfere with C-g's normal operation in other contexts.


;; Close *Warnings* and *Backtrace* windows with C-g
(defun sunra/close-other-windows ()
  "Close auxiliary windows: *Warnings*, *Backtrace*, *Help*,
   and any window whose buffer name matches \"-compilation\"."
  (interactive)
  (dolist (win (window-list))
    (let* ((buf (window-buffer win))
           (name (buffer-name buf)))
      (when (or (member name '("*Warnings*" "*Backtrace*" "*Help*"))
                (string-match-p "-compilation" name)
                (string-match-p "magit: " name)
                (string-match-p "magit-diff:" name)
                (string-match-p "magit-log" name)
                (string-match-p "Free keys" name)
                (string-match-p "Apropos" name)
                (string-match-p "*Diff*" name))
        (quit-window nil win)))))

(defun sunra/keyboard-quit-with-other-window-handling ()
  "Call `keyboard-quit' and close other windows."
  (interactive)
  (sunra/close-other-windows)
  (keyboard-quit))

(global-set-key (kbd "C-g") 'sunra/keyboard-quit-with-other-window-handling)


(provide 'sunra-windows)
