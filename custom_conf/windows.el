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
  ("C-c %" . golden-ratio)
  ("C-c M-%" . golden-ratio-mode))

(winner-mode t)

(provide 'windows)
