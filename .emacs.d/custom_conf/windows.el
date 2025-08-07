(use-package popper
  :ensure t
  :bind (("C-c C-SPC" . popper-toggle)
         ("M-`" . popper-cycle)
         ("C-c M-`" . popper-toggle-type))
  :custom
  (popper-window-height 16)
  (popper-reference-buffers '("\\*Messages\\*"
                              ;; "Output\\*$"
                              "\\*xref\\*"
                              "\\*Async Shell Command\\*"
                              "\\*eldoc"
                              "\\*Flymake diagnostics"
                              "\\*sqls\\*"
                              "\\*eat\\*"
                              "\\*Warnings\\*"
                              "\\*sly-xref"
                              eshell-mode
                              vterm-mode
                              help-mode
                              eat-mode
                              compilation-mode))
  :init
  (popper-mode +1)
  (popper-echo-mode +1))

(use-package ace-window
  :ensure t
  :config
  (setq aw-scope 'frame)
  (setq aw-keys '(?1 ?2 ?3 ?q ?w ?e ?a ?s ?d))
  (setq aw-make-frame-char ?`)
  :bind
  ("M-o" . ace-window)
  ("C-x w x" . ace-swap-window)
  ("C-x w k" . ace-delete-window)
  ("C-x w K" . ace-delete-other-windows))

;; (use-package windmove
;;   :ensure t
;;   :config
;;   (windmove-mode t)
;;   ;; (windmove-default-keybindings)
;;   ;; (windmove-swap-states-default-keybindings)
;;   ;; (windmove-display-default-keybindings)
;;   ;; (windmove-delete-default-keybindings)
;;   )

(use-package golden-ratio
  :ensure t
  :bind
  ("C-x w %" . golden-ratio)
  ("C-x w M-%" . golden-ratio-mode))

(winner-mode t)

(use-package cycle-resize
  :ensure t
  :config
  (setq cycle-resize-steps '(66 50 33 50))
  :bind
  ("C-x w n" . cycle-resize-window-vertically)
  ("C-x w f" . cycle-resize-window-horizontally)
  ("C-x w SPC" . cycle-resize-window-horizontally))

(use-package windresize
  :ensure t
  :bind
  ("C-x w w" . windresize))

(defun pop-vterm-middle ()
  (interactive)
  (let* ((name "*vterm-popup*")
         (width (max 140 (/ (frame-width) 2)))
         (height (/ (frame-height) 2))
         (f (posframe-show
             (or (get-buffer name) (vterm--internal #'ignore name))
             :poshandler #'posframe-poshandler-frame-center
             :left-fringe 8
             :right-fringe 8
             :width width
             :height height
             :min-width width
             :min-height height
             :internal-border-width 3
             :cursor t
             :internal-border-color (face-foreground 'org-warning nil t)
             ;; :background-color (face-background 'tooltip nil t)
             :accept-focus t)))
    ;; (set-frame-parameter f 'alpha '(80))
    ;; (modify-frame-parameters f '((alpha . 80)))
    (select-frame-set-input-focus f)
    (with-selected-frame f
      (with-current-buffer (get-buffer name)
        (goto-char (1- (point-max)))))))

(bind-key (kbd "C-x 5 `") #'pop-vterm-middle)

(provide 'windows)
