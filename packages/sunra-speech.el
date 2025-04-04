
;; Whisper.el for Speech-to-Text
;; 1. Clone the repository
;; In terminal:
;; git clone https://github.com/natrys/whisper.el ~/.emacs.d/lisp/whisper.el

;; 2. Add to your Emacs configuration
;; (use-package whisper
;;   :load-path "~/.emacs.d/lisp/whisper.el"
;;   :bind ("C-c w" . whisper-run)
;;   :init
;;   ;; Create a function to add whisper.cpp to load-path when it becomes available
;;   (defun whisper-maybe-add-to-load-path ()
;;     "Add whisper.cpp directory to load-path if it exists."
;;     (let ((whisper-cpp-dir (expand-file-name "whisper.cpp" whisper-install-directory)))
;;       (when (file-directory-p whisper-cpp-dir)
;;         (add-to-list 'load-path whisper-cpp-dir))))
;;   
;;   ;; Add a hook to run after whisper.el installs whisper.cpp
;;   (add-hook 'whisper-after-install-hook #'whisper-maybe-add-to-load-path)
;;   
;;   :config
;;   (setq whisper-install-directory "~/.emacs.d/.cache/"  ;; Where whisper.cpp will be installed
;;         whisper-model "base"                            ;; Model size (tiny, base, small, medium, large)
;;         whisper-language "en"                           ;; Language code
;;         whisper-translate nil                           ;; Don't translate to English
;;         whisper-use-threads 4)
;;   
;;   ;; Also check immediately in case whisper.cpp is already installed
;;   (whisper-maybe-add-to-load-path))


(use-package whisper
  :load-path "~/.emacs.d/lisp/whisper.el"
  :bind ("C-c w" . whisper-run)
  :init
  ;; Create a function to add whisper.cpp to load-path when it becomes available
  (defun whisper-maybe-add-to-load-path ()
    "Add whisper.cpp directory to load-path if it exists."
    (let ((whisper-cpp-dir (expand-file-name "whisper.cpp" whisper-install-directory)))
      (when (file-directory-p whisper-cpp-dir)
        (add-to-list 'load-path whisper-cpp-dir))))
  
  ;; Add a hook to run after whisper.el installs whisper.cpp
  (add-hook 'whisper-after-install-hook #'whisper-maybe-add-to-load-path)
  
  :config
  (setq whisper-install-directory "~/.emacs.d/.cache/"  ;; Where whisper.cpp will be installed
        whisper-model "base"                            ;; Model size (tiny, base, small, medium, large)
        whisper-language "en"                           ;; Language code
        whisper-translate nil                           ;; Don't translate to English
        whisper-use-threads 4)
  
  ;; MacOS specific configuration for audio input
  (when (eq system-type 'darwin)
    (setq whisper--ffmpeg-input-format "avfoundation"
          whisper--ffmpeg-input-device ":0"))  ;; ":0" typically refers to the default input device
  
  ;; Also check immediately in case whisper.cpp is already installed
  (whisper-maybe-add-to-load-path))


(provide 'sunra-speech)
