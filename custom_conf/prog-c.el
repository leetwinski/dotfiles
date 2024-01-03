(use-package c-mode
  :defer t
  :hook (c-mode . (lambda ()
                    (eldoc-mode 1)
                    (eglot-ensure))))

(provide 'prog-c)
