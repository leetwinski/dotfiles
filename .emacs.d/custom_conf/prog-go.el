(use-package go-mode
  :ensure t
  :defer t
  :hook
  (go-mode . (lambda ()
               (eldoc-mode 1)
               (eglot-ensure))))

(provide 'prog-go)
