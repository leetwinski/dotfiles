(use-package julia-mode
  :ensure t
  :defer t
  :mode "\\.jl\\'")


(use-package julia-snail
  :ensure t
  :hook (julia-mode . (lambda ()
                        (eldoc-mode +1)
                        (julia-snail-mode t))))

;; (use-package eglot-jl
;;   :ensure t
;;   :after (julia-mode)
;;   :init
;;   (eglot-jl-init)
;;   :hook
;;   (julia-mode . eglot-ensure))

(provide 'prog-julia)
