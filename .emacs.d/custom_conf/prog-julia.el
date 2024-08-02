(use-package julia-mode
  :ensure t
  :defer t
  :mode "\\.jl\\'")

(use-package julia-snail
  :ensure t
  :defer t
  :config
  (setf julia-snail-multimedia-enable t)
  (setf julia-snail-multimedia-buffer-autoswitch t)
  :hook (julia-mode . (lambda ()
                        (julia-snail-mode 1)
                        (eldoc-mode +1))))

;; (use-package eglot-jl
;;   :ensure t
;;   :after (julia-mode)
;;   :config
;;   (setf eglot-connect-timeout 300)
;;   :init
;;   (eglot-jl-init)
;;   :hook
;;   (julia-mode . eglot-ensure))

(provide 'prog-julia)
