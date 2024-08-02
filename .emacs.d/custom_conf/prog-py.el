(add-hook 'python-mode-hook
          (lambda ()
            (python-ts-mode)
            (eglot-ensure)
            (eldoc-mode +1)))

;; (use-package eglot-jl
;;   :ensure t
;;   :after (julia-mode)
;;   :config
;;   (setf eglot-connect-timeout 300)
;;   :init
;;   (eglot-jl-init)
;;   :hook
;;   (julia-mode . eglot-ensure))

(provide 'prog-py)
