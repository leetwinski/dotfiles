(use-package eglot-java
  :defer t
  :after (java-mode)
  :ensure t)

(add-hook 'java-mode-hook (lambda ()
                            (eglot-ensure)
                            (eglot-java-mode 1)
                            (eldoc-mode +1)))

(use-package groovy-mode
  :defer t
  :ensure t)

(provide 'prog-java)
