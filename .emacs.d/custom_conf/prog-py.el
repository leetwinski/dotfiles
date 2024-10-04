(add-hook 'python-mode-hook
          (lambda ()
            (eglot-ensure)
            (eldoc-mode +1)))

(add-hook 'python-ts-mode-hook
          (lambda ()
            (eglot-ensure)
            (eldoc-mode +1)))

(provide 'prog-py)
