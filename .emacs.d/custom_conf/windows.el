(use-package popper
  :ensure t
  :bind (("C-c C-SPC" . popper-toggle)
         ("M-`" . popper-cycle)
         ("C-c M-`" . popper-toggle-type))
  :custom
  (popper-window-height 16)
  (popper-reference-buffers '("\\*Messages\\*"
                              "Output\\*$"
                              "\\*xref\\*"
                              "\\*Async Shell Command\\*"
                              "\\*eldoc"
                              "\\*Flymake diagnostics"
                              "\\*sqls\\*"
                              eshell-mode
                              vterm-mode
                              help-mode
                              compilation-mode))
  :init
  (popper-mode +1)
  (popper-echo-mode +1))

(use-package ace-window
  :ensure t
  :config
  (setq aw-scope 'frame)
  (setq aw-keys '(?q ?w ?e ?r ?a ?s ?d ?f ?z ?x ?c ?v))
  :bind
  ("M-o" . ace-window))

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

(provide 'windows)
