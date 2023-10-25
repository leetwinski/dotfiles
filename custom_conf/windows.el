(use-package popper
  :ensure t ; or :straight t
  :bind (("C-c `"   . popper-toggle-latest)
         ("M-`"   . popper-cycle)
         ("C-c M-`" . popper-toggle-type))
  :custom
  (popper-window-height 14)
  (popper-reference-buffers '("\\*Messages\\*"
                              "Output\\*$"
                              "\\*xref\\*"
                              "\\*Async Shell Command\\*"
                              "\\*eldoc"
                              "\\*Flymake diagnostics"
                              eshell-mode
                              vterm-mode
                              help-mode
                              compilation-mode))
  :init
  (popper-mode +1)
  (popper-echo-mode +1))

(use-package windmove
  :ensure t
  :config
  (windmove-mode t)
  (windmove-default-keybindings)
  (windmove-swap-states-default-keybindings)
  (windmove-display-default-keybindings)
  (windmove-delete-default-keybindings))

(use-package golden-ratio
  :ensure t
  :bind
  ("C-c r %" . golden-ratio)
  ("C-c r M-%" . golden-ratio-mode))

(winner-mode t)

(use-package cycle-resize
  :ensure t
  :config
  (setq cycle-resize-steps '(66 50 33 50))
  :bind
  ("C-c r n" . cycle-resize-window-vertically)
  ("C-c r f" . cycle-resize-window-horizontally)
  ("C-c r SPC" . cycle-resize-window-horizontally))

(use-package windresize
  :ensure t
  :bind
  ("C-c r r" . windresize))

(provide 'windows)
