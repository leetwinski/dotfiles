(use-package markdown-mode
  :ensure t
  :defer t
  :hook (markdown-mode . (lambda ()
                           (eldoc-mode 1)
                           (eglot-ensure))))

(provide 'doc-md)
