

;; Overview
;; Reimplementation of the `map!` macro from Doom Emacs' implementation that does not rely on Evil or general.el.
;; https://github.com/doomemacs/doomemacs/blob/master/lisp/doom-keybinds.el
;;
;; The implementation supports an optional :dependencies keyword whose list of packages is required (via require) before any keybindings are set. In this example the macro accepts a sequence of keywords and keybinding definitions; if a :map keyword precedes keybindings, those bindings will be applied to that specific keymap using define-key. If no map is provided, global-set-key is used.

;; Explanation:
;; 1. The macro starts by initializing three variables:  
;;    - dependencies: accumulates packages to be loaded  
;;    - bindings: stores triples of (map key command)  
;;    - current-map: holds the active keymap (if any)
;; 2. The while loop scans the arguments. When encountering a keyword, it checks whether it’s :dependencies (in which case it expects the next element to be a list of package symbols) or :map (in which case it expects a keymap symbol). If a string is encountered it assumes a keybinding definition and pairs it with the following command symbol.
;; 3. In the expander phase, the macro builds a progn with:
;;    - a series of (require 'package) calls for each dependency;
;;    - a series of keybinding definitions via define-key (if a map is specified) or global-set-key.
;; 4. The key sequence strings are converted using (kbd "…") to allow natural Emacs key syntax.
;; 
;; This simple reimplementation demonstrates a method of binding keys declaratively, while ensuring any package dependencies are loaded first. Although Doom’s original macro has more syntactic sugar and flexibility, this version captures the core functionality without relying on either Evil or general.el.

(defmacro map! (&rest args)
  "Bind keys and load dependencies.
   Optional keywords:
   :dependencies  A list of package symbols to load (via require)
   :map           A keymap where subsequent key definitions should be applied.
                  Key definitions should have the form (\"key sequence\" command)."
  (let ((dependencies '())
        (bindings '())
        (current-map nil))
    (while args
      (let ((token (pop args)))
        (cond
         ;; Process :dependencies keyword; expect a list of package symbols.
         ((and (keywordp token) (eq token :dependencies))
          (setq dependencies (pop args)))
         ;; Process :map keyword; expect a keymap symbol.
         ((and (keywordp token) (eq token :map))
          (setq current-map (pop args)))
         ;; If token is a string, assume it’s a key sequence; the next item is a command
         ((stringp token)
          (let ((key token)
                (cmd (pop args)))
            (push (list current-map key cmd) bindings)))
         (t
          (error "Unknown token in map!: %s" token)))))
    `(progn
       ;; Ensure all dependencies are loaded.
       ,@(mapcar (lambda (pkg) `(require ',pkg)) dependencies)
       ;; Define all keybindings.
       ,@(mapcar (lambda (binding)
                   (let ((map (nth 0 binding))
                         (key (nth 1 binding))
                         (cmd (nth 2 binding)))
                     (if map
                         `(define-key ,map (kbd ,key) ,cmd)
                       `(global-set-key (kbd ,key) ,cmd))))
                 (nreverse bindings)))))

(use-package which-key

  :ensure t
  :config (which-key-mode))

(provide 'sunra-keybinds)
