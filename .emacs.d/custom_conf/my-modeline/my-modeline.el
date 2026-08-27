(require 'doom-modeline)

(defvar my-modeline-bar-length 10
  "Number of cells in the progress bar.")

(defvar my-modeline-bar-image-active
  (create-image "~/.emacs.d/custom_conf/my-modeline/piotr.png" 'png nil
                :ascent 'center :width 20 :height 20 :mask 'heuristic))

(defun my-modeline--percent ()
  (let* ((current-line (line-number-at-pos (point)))
         (total-lines (line-number-at-pos (point-max))))
    (if (<= total-lines 1)
        100
      (round (* 100 (/ (float (1- current-line)) (1- total-lines)))))))

(defun filler ()
  (if (display-graphic-p) ?〰 ?_))

(defvar my-modeline-line-goto-map
  (let ((map (make-sparse-keymap)))
    (define-key map [mode-line mouse-1] #'my-modeline-goto-relative-line)
    map)
  "Keymap for clicking the progress bar segment.")

(defun my-modeline-goto-relative-line (event)
  "Jump to the buffer line corresponding to where the progress bar was clicked."
  (interactive "e")
  (let* ((pos (event-start event))
         (window (posn-window pos))
         (str-pos (posn-string pos)))
    (when (and window str-pos)
      (let* ((idx (max 0 (1- (cdr str-pos))))   ; drop the leading space char
             (ratio (min 1.0 (/ (float idx) my-modeline-bar-length))))
        (with-selected-window window
          (let ((total (line-number-at-pos (point-max))))
            (goto-char (point-min))
            (forward-line (round (* ratio (1- total))))))))))

(defun my-modeline--bar (percent)
  "Build a clickable text progress bar string for PERCENT (0-100)."
  (let* ((filled (round (* my-modeline-bar-length (/ percent 100.0))))
         (empty (- my-modeline-bar-length filled)))
    (propertize
     (concat
      " "
      (propertize (make-string filled (filler)) 'face '(:foreground "#00ff88"))
      (if (display-graphic-p)
          (propertize " " 'display my-modeline-bar-image-active)
        "🐢")
      (propertize (make-string empty (filler)) 'face '(:foreground "gray")))
     'local-map my-modeline-line-goto-map
     ;; 'mouse-face 'mode-line-highlight
     'help-echo "mouse-1: go to relative line")))

(defun my-modeline-position-indicator ()
  (let ((percent (my-modeline--percent)))
    (my-modeline--bar percent)))

(doom-modeline-def-segment my-progress-indicator
  (my-modeline-position-indicator))

;; (doom-modeline-def-modeline 'main
;;   '(eldoc bar window-state workspace-name window-number modals drag-stuff matches follow buffer-info remote-host my-indicator buffer-position word-count parrot selection-info)
;;   '(compilation objed-state misc-info project-name persp-name battery grip irc mu4e gnus github debug repl lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs check time))

(provide 'my-modeline)
