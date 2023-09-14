(use-package eglot-java
  :ensure t)

(add-hook 'java-mode-hook (lambda ()
                            (eglot-ensure)
                            (eglot-java-mode 1)
                            (eldoc-mode +1)))

(use-package groovy-mode
  :ensure t)

(provide 'prog-java)
