(use-package go-mode
  :ensure t
  :defer t
  :hook
  (go-ts-mode . (lambda ()
                  (setq-local go-ts-mode-indent-offset 4)
                  (setq-local fill-column 100)
                  (eldoc-mode 1)
                  (eglot-ensure)))
  (go-mode . (lambda ()
               (setq-local fill-column 100)
               (eldoc-mode 1)
               (eglot-ensure))))

(provide 'prog-go)
