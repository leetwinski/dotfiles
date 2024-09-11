(use-package julia-mode
  :ensure t
  :defer t
  :mode "\\.jl\\'")

(use-package julia-snail
  :ensure t
  ;; :defer t
  :init
  (setf julia-snail-multimedia-enable t)
  (setf julia-snail-multimedia-buffer-autoswitch t)
  ;; :custom
  ;; (julia-snail-extensions '(ob-julia))
  ;; (julia-snail-multimedia-enable t)
  ;; (julia-snail-multimedia-buffer-autoswitch t)
  ;; (julia-snail/ob-julia-capture-io nil)
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
