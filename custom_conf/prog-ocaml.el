(use-package tuareg
  :ensure t)

(add-hook 'tuareg-mode-hook (lambda ()
                             (eglot-ensure)
                             (eldoc-mode +1)))

(provide 'prog-ocaml)
