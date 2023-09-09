(use-package eglot-java
  :ensure t
  :hook
  (java-mode . eglot-java-mode))

(use-package java-mode
  :mode "\\.java\\'"
  :hook
  (java-mode . (lambda ()
                 (eglot-ensure t)
                 (eldoc-mode +1))))

(provide 'prog-java)
