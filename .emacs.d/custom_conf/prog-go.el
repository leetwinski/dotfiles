(use-package go-mode
  :ensure t
  :defer t
  :hook
  (go-ts-mode . (lambda ()
                  (setf go-ts-mode-indent-offset 4)
                  (eldoc-mode 1)
                  (eglot-ensure)))
  (go-mode . (lambda ()
               (eldoc-mode 1)
               (eglot-ensure))))

(provide 'prog-go)
