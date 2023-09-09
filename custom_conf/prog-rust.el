(use-package rust-mode
  :ensure t
  :defer t
  :mode "\\.rs\\'"
  :hook
  (rust-mode . (lambda ()
                 (eglot-ensure)
                 (eldoc-mode +1))))

(use-package cargo-mode
  :ensure t
  :defer t
  :commands (cargo-minor-mode)
  :hook
  (rust-mode . cargo-minor-mode))

(provide 'prog-rust)
