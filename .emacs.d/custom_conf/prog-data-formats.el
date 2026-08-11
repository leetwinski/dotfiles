(use-package json-mode
  :ensure t
  :defer t
  :hook
  (json-mode . (lambda ()
                 (eldoc-mode 1)
                 (eglot-ensure))))

(use-package so-long
  :ensure t
  :config (global-so-long-mode))

(use-package json-ts-mode
  :mode "\\.json\\'\\|json\\.schema\\'"
  :custom (json-ts-mode-indent-offset 4)
  :hook (json-ts-mode . (lambda ()
                          (eldoc-mode 1)
                          (eglot-ensure))))

;; (use-package jsonian
;;   :ensure t
;;   :defer t
;;   :mode "\\.json\\'"
;;   :after so-long
;;   :hook (jsonian-mode . (lambda ()
;;                           (eldoc-mode 1)
;;                           (eglot-ensure)))
;;   :custom
;;   (jsonian-no-so-long-mode))

(use-package csv-mode
  :ensure t
  :defer t)

(use-package toml-mode
  :ensure t
  :defer t)

(use-package yaml-mode
  :ensure t
  :mode "\\.ya?ml\\'"
  :hook
  (yaml-ts-mode . (lambda ()
                    (eldoc-mode 1)
                    (eglot-ensure)))
  (yaml-mode . (lambda ()
                 (eldoc-mode 1)
                 (eglot-ensure))))

(use-package protobuf-mode
  :ensure t
  :mode "\\.proto\\'")

(provide 'prog-data-formats)
