(use-package zig-mode
  :ensure t
  :defer t
  :hook
  (zig-mode . (lambda ()
                (eldoc-mode 1)
                (eglot-ensure))))

(provide 'prog-zig)
