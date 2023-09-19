(use-package markdown-mode
  :ensure t
  :hook (markdown-mode . (lambda ()
                           (eldoc-mode 1)
                           (eglot-ensure))))

(provide 'doc-md)
