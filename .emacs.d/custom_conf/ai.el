(use-package password-store
  :ensure t
  :defer t)

(use-package agent-shell :ensure t
  :init
  (defvar my/agent-shell-keymap (make-sparse-keymap))
  :custom
  (agent-shell-anthropic-authentication
   (agent-shell-anthropic-make-authentication :login t))
  (agent-shell-header-style 'text)
  (agent-shell-screenshot-command (list "import"))
  :bind-keymap ("C-c s" . my/agent-shell-keymap)
  :bind
  (:map my/agent-shell-keymap
        ("s" . agent-shell-send-dwim)
        ("r" . agent-shell-send-region)
        ("R" . agent-shell-send-region-to)
        ("f" . agent-shell-send-file)
        ("F" . agent-shell-send-file-to)
        ("o" . agent-shell-send-other-file)
        ("c" . agent-shell-send-clipboard-image)
        ("!" . agent-shell-send-screenshot)
        ("SPC" . agent-shell-toggle)))


(provide 'ai)
