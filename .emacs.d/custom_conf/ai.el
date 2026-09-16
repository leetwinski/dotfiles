;;; -*- lexical-binding: t; -*-

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

(use-package agent-shell-notifications
  :straight (agent-shell-notifications
             :type git
             :host github
             :repo "zackattackz/agent-shell-notifications")

  :hook
  ;; Enable notifications in each agent-shell buffer
  (agent-shell-mode . agent-shell-notifications-mode)
  ;; If using agent-shell-viewport, also add:
  ;; (agent-shell-viewport-edit-mode . agent-shell-notifications-viewport-edit-mode)
  ;; (agent-shell-viewport-view-mode . agent-shell-notifications-viewport-view-mode)

  :config
  ;; Notification display timeout in seconds (0 = never expire (the default), -1 = backend default)
  ;; (setq agent-shell-notifications-timeout 5)

  ;; Seconds to wait before notifying when the shell is already visible (default: 10)
  ;; (setq agent-shell-notifications-idle-timeout 30)

  ;; Advanced filtering: suppress notifications during certain hours
  ;; (add-hook 'agent-shell-notifications-inhibit-functions
  ;;           (lambda (_type _event)
  ;;             (let ((hour (decoded-time-hour (decode-time))))
  ;;               (and (>= hour 9) (< hour 17)))))

  ;; Use the knockknock backend instead of the default libnotify
  ;; (setq agent-shell-notifications-provider 'agent-shell-notifications-knockknock)
  )


(provide 'ai)
