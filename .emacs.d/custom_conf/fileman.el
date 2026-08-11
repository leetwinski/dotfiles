
;; dired edit file name at point
(use-package wdired
  :ensure t
  :bind
  (:map wdired-mode-map
        ("C-c '" . wdired-finish-edit)))

(use-package dired
  :bind
  (:map dired-mode-map
        ("K" . dired-kill-subdir)
        ("C-c '" . wdired-change-to-wdired-mode))
  (:map search-map
        ("M-/" . find-grep-dired)
        ("/" . find-name-dired))
  :custom
  (dired-listing-switches "-lah")
  (dired-create-destination-dirs 'ask)
  (dired-create-destination-dirs-on-trailing-dirsep t)
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
  :defer t
  :custom-face (treemacs-window-background-face ((t (:background "grey9"))))
  )

(use-package project-treemacs
  :ensure t
  :demand t
  :defer t
  ;; :after (treemacs)
  :config
  (project-treemacs-mode)
  (treemacs-project-follow-mode 1)
  (setf treemacs-project-follow-cleanup t)
  :bind
  (:map project-prefix-map
        ("t" . treemacs)))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))

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

;; (use-package treemacs-icons-dired
;;   :ensure t
;;   :init
;;   :hook
;;   (dired-mode . (lambda ()
;;                   ;; avoid turning enabling nerd-icons-dired for tramp buffers
;;                   ;; as it seems to slow down the display
;;                   (unless (file-remote-p default-directory)
;;                     (treemacs-icons-dired-mode 1))))
;;   )

(use-package nerd-icons-dired
  :ensure t
  :defer t
  :hook
  (dired-mode . (lambda ()
                  ;; avoid turning enabling nerd-icons-dired for tramp buffers
                  ;; as it seems to slow down the display
                  (unless (file-remote-p default-directory)
                    (nerd-icons-dired-mode 1)))))

(use-package diredfl
  :ensure t
  :defer t
  ;; :config
  ;; (diredfl-global-mode)
  :hook
  (dired-mode . diredfl-mode))

(provide 'fileman)
