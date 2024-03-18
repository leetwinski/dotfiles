(use-package tuareg
  :defer t
  :ensure t)

(add-hook 'tuareg-mode-hook (lambda ()
                             (eglot-ensure)
                             (eldoc-mode +1)))

(provide 'prog-ocaml)
