(use-package go-mode
  :ensure t
  :hook
  (go-mode . (lambda ()
               (eldoc-mode 1)
               (eglot-ensure)
               (add-hook 'before-save-hook #'eglot-format-buffer -10 t))))

(provide 'prog-go)
