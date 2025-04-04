(require 'cl-lib)

(defun screenshot (&optional emacs-frame-only)
  "Take a screenshot and save it to a file.
With prefix argument ARG, capture the current active Emacs frame only.
Otherwise, capture the entire screen."
  (interactive "P")
  (let* ((default-directory (expand-file-name "~/Pictures/"))
         (timestamp (format-time-string "%Y%m%d-%H%M%S"))
         (file-name (concat "screenshot-" timestamp ".png"))
         (full-path (expand-file-name file-name))
         (command
          (cond
           ((eq system-type 'darwin)
            (if emacs-frame-only
                (format "screencapture -l$(osascript -e 'tell app \"Emacs\" to id of window 1') %s"
                        (shell-quote-argument full-path))
              (format "screencapture %s"
                      (shell-quote-argument full-path))))
           ((eq system-type 'gnu/linux)
            (if emacs-frame-only
                (format "ffmpeg -y -f x11grab -i 0x%s -vframes 1 %s"
                        (frame-parameter nil 'outer-window-id)
                        (shell-quote-argument full-path))
              (format "ffmpeg -y -f x11grab -i :0 -vframes 1 %s"
                      (shell-quote-argument full-path))))
           (t (error "No suitable screenshot command found for this system")))))
    (make-directory (file-name-directory full-path) t)
    (if (zerop (shell-command command))
        (progn
          (message "Screenshot saved to %s" full-path)
          (when (y-or-n-p "Open screenshot? ")
            (find-file full-path)))
      (error "Failed to take screenshot"))))


;; `screenshot` is an Emacs lisp function that can
;; i. take a shot of desktop screen or ii. shot of an active Emacs window
;; using the CLI =Image Magick=, or ~screencapture~ on MacOS
;;
;; Usage
;; ;; (setq debug-on-error t)
;; ;; (toggle-debug-on-error)

;; (screenshot)
;; (screenshot t)

(defun screencapture (screen-id &optional duration)
  "Record the screen with SCREEN-ID for DURATION seconds using ffmpeg’s avfoundation input.
   SCREEN-ID is the device index shown when running:
   ffmpeg -f avfoundation -list_devices true -i \"\"

By default, DURATION is 5 seconds.  The resulting file is placed in ~/Pictures/ with a timestamp.

On non-macOS systems, this function currently signals an error."
  (interactive "nEnter screen device index: \nnDuration in seconds (default 5): ")
  (unless duration
    (setq duration 5))

  (let* ((default-directory (expand-file-name "~/Pictures/"))
         (timestamp (format-time-string "%Y%m%d-%H%M%S"))
         (file-name (concat "screencapture-" timestamp ".mp4"))
         (full-path (expand-file-name file-name))
         ;; Construct the ffmpeg command for avfoundation
         (command (format "ffmpeg -y -f avfoundation -i %s:0 -t %s %s"
                          screen-id
                          duration
                          (shell-quote-argument full-path))))
    (make-directory (file-name-directory full-path) t)
    (if (zerop (shell-command command))
        (progn
          (message "Screen recording saved to %s" full-path))
      (error "Failed to record from screen ID %s" screen-id))))

;; Usage

;; Record the desktop from screen 3 for 10 seconds
;; (screencapture 3 10)
;;
;; Record the desktop from screen 2 for 5 seconds
;; (screencapture 2 5)

;; # ffmpeg can list out the available desktop screen devices
;; ffmpeg -f avfoundation -list_devices true -i ""
;; ...
;; [AVFoundation indev @ 0x12a804080] AVFoundation video devices:
;; [AVFoundation indev @ 0x12a804080] [0] LG UltraFine Display Camera
;; [AVFoundation indev @ 0x12a804080] [1] FaceTime HD Camera
;; [AVFoundation indev @ 0x12a804080] [2] Capture screen 0
;; [AVFoundation indev @ 0x12a804080] [3] Capture screen 1
;; [AVFoundation indev @ 0x12a804080] AVFoundation audio devices:
;; [AVFoundation indev @ 0x12a804080] [0] LG UltraFine Display Audio
;; [AVFoundation indev @ 0x12a804080] [1] MacBook Pro Microphone
;; [AVFoundation indev @ 0x12a804080] [2] Bose QC45

(provide 'sunra-desktop)
