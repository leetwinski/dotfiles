
;; dired edit file name at point

(use-package dired
  :bind
  (:map dired-mode-map
        ("K" . dired-kill-subdir)
        ("C-c C-p" . wdired-change-to-wdired-mode))
  (:map search-map
        ("M-/" . find-grep-dired)
        ("/" . find-name-dired))
  :hook
  (dired-mode . (lambda () (toggle-truncate-lines 1))))

(use-package dired-efap
  :ensure t
  :after (dired)
  :bind
  (:map dired-mode-map
        ("E" . dired-efap)))

(use-package dired-filter
  :ensure t
  :defer t
  :after (dired)
  :hook (dired-mode . (lambda () (dired-filter-mode t))))

(use-package treemacs
  :ensure t
  ;; :defer t
  )

(use-package project-treemacs
  :ensure t
  :demand t
  :after (treemacs)
  :config
  (project-treemacs-mode)
  :bind
  (:map project-prefix-map
        ("t" . treemacs)))

(use-package treemacs-magit
  :ensure t
  :defer t
  :after (treemacs magit))

(use-package treemacs-nerd-icons
  :ensure t
  ;; :defer t
  :after (treemacs)
  :config
  (treemacs-load-theme "nerd-icons"))

(use-package nerd-icons-dired
  :ensure t
  :config
  (eval-after-load 'wdired
    (advice-add 'wdired-abort-changes :around #'nerd-icons-dired--refresh-advice))
  :hook
  (dired-mode . (lambda ()
                  ;; avoid turning enabling nerd-icons-dired for tramp buffers
                  ;; as it seems to slow down the display
                  (unless (file-remote-p default-directory)
                    (nerd-icons-dired-mode 1)))))

(use-package diredfl
  :ensure t
  :hook
  (dired-mode . diredfl-mode))

(provide 'fileman)
