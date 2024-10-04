;; (use-package markdown-ts-mode
;;   :ensure t
;;   :hook (markdown-ts-mode . (lambda ()
;;                               (eldoc-mode 1)
;;                               (eglot-ensure))))

(use-package markdown-mode
  :ensure t
  :defer t
  :hook
  (markdown-mode . (lambda ()
                     (eldoc-mode 1)
                     (eglot-ensure))))

(provide 'doc-md)
