(use-package popper
  :ensure t
  :bind (("C-c C-SPC" . popper-toggle)
         ("C-c `" . popper-cycle)
         ("C-c M-`" . popper-toggle-type))
  :custom
  (popper-group-function #'popper-group-by-project)

  (popper-window-height 16)
  (popper-reference-buffers '("\\*Messages\\*"
                              ;; "Output\\*$"
                              "\\*xref\\*"
                              "\\*Async Shell Command\\*"
                              "\\*Shell Command Output\\*"
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
                              ghostel-mode
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

(use-package golden-ratio
  :ensure t
  :bind
  ("C-x w %" . golden-ratio)
  ("C-x w M-%" . golden-ratio-mode)
  :config (add-to-list 'golden-ratio-inhibit-functions
                       (lambda () (and (boundp 'popper-popup-status)
                                  (popper-popup-p (current-buffer))))))

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

(provide 'windows)
