;; (use-package json-mode
;;   :ensure t
;;   :defer t)

(use-package so-long
  :ensure t)

(use-package jsonian
  :ensure t
  ;; :defer t
  :after so-long
  :hook (jsonian-mode . (lambda ()
                          (eldoc-mode 1)
                          (eglot-ensure)))
  :custom
  (jsonian-no-so-long-mode))

(use-package csv-mode
  :ensure t
  :defer t)

(use-package toml-mode
  :ensure t
  :defer t)

(use-package yaml-mode
  :ensure t
  :hook (yaml-mode . (lambda ()
                       (eldoc-mode 1)
                       (eglot-ensure))))

(provide 'prog-data-formats)
