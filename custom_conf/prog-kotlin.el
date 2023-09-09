(use-package kotlin-mode
  :ensure t
  :defer t
  :config
  (setq-default kotlin-tab-width 4)
  :hook
  (kotlin-mode . (lambda ()
                   (eldoc-mode t)
                   (eglot-ensure))))

(provide 'prog-kotlin)
