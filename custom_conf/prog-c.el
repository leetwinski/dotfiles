(use-package c-mode
  :defer t
  :hook (c-mode . (lambda ()
                    (eldoc-mode 1)
                    (eglot-ensure))))

;; (use-package zig-mode
;;   :ensure t
;;   :defer t
;;   :hook
;;   (zig-mode . (lambda ()
;;                 (eldoc-mode 1)
;;                 (eglot-ensure))))

(provide 'prog-c)
