(use-package org-roam
  :ensure t
  :defer t
  :config
  (org-roam-db-autosync-mode +1)
  :custom
  (org-roam-directory "~/org/roam"))

(use-package org-agenda
  :custom
  (setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))
  :bind
  ("C-c a" . org-agenda))

;; (use-package org-modern
;;   :ensure t
;;   :after (org)
;;   :config
;;   (global-org-modern-mode +1))

;; (use-package poly-org
;;   :ensure t
;;   :defer t
;;   :hook (org-mode . (lambda () (poly-org-mode t))))

;; (defun flycheck-buffer-not-indirect-p (&rest _)
;;   "Ensure that the current buffer is not indirect."
;;   (null (buffer-base-buffer)))

;; (advice-add 'flycheck-may-check-automatically
;;             :before-while
;;             #'flycheck-buffer-not-indirect-p)

(use-package org-src
  :bind
  (:map org-src-mode-map
        ("C-c C-c" . org-edit-src-exit)))

(use-package ob-restclient
  :ensure t
  :defer t)

(use-package ob-go
  :ensure t
  :defer t)

(use-package ob-bigquery
  :ensure t
  :defer t)

(add-hook 'org-mode-hook (lambda ()
                           (yas-minor-mode t)
                           ;; org-babel settings
                           (setf org-babel-lisp-eval-fn 'sly-eval)
                           (org-babel-do-load-languages
                            'org-babel-load-languages
                            '((lisp . t)
                              (mermaid . t)
                              (clojure . t)
                              (shell . t)
                              (js . t)
                              (C . t)
                              (java . t)
                              (go . t)
                              (restclient . t)
                              (julia . t)
                              (makefile . t)
                              (ocaml . t)
                              (python . t)
                              (gnuplot . t)
                              (latex . t)
                              (bigquery . t)
                              ;; (maxima . t)
                              (processing . t)
                              ;; (sclang . t)
                              ))))

(use-package consult-org-roam
   :ensure t
   :after org-roam
   :init
   (require 'consult-org-roam)
   ;; Activate the minor mode
   (consult-org-roam-mode 1)
   :custom
   ;; Use `ripgrep' for searching with `consult-org-roam-search'
   (consult-org-roam-grep-func #'consult-ripgrep)
   ;; Configure a custom narrow key for `consult-buffer'
   (consult-org-roam-buffer-narrow-key ?r)
   ;; Display org-roam buffers right after non-org-roam buffers
   ;; in consult-buffer (and not down at the bottom)
   (consult-org-roam-buffer-after-buffers t)
   :config
   ;; Eventually suppress previewing for certain functions
   (consult-customize
    consult-org-roam-forward-links
    :preview-key "M-.")
   :bind
   ;; Define some convenient keybindings as an addition
   ("M-s \\ f" . consult-org-roam-file-find)
   ("M-s \\ b" . consult-org-roam-backlinks)
   ("M-s \\ B" . consult-org-roam-backlinks-recursive)
   ("M-s \\ l" . consult-org-roam-forward-links)
   ("M-s \\ s" . consult-org-roam-search))

(use-package embark-org-roam
  :ensure t
  :after (org-roam embark))

(provide 'org-stuff)
