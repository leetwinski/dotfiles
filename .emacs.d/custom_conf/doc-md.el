;; (use-package markdown-ts-mode
;;   :ensure t
;;   :hook (markdown-ts-mode . (lambda ()
;;                               (eldoc-mode 1)
;;                               (eglot-ensure))))

(use-package markdown-mode
  :ensure t
  :defer t
  :custom (markdown-command "multimarkdown")
  :hook
  (markdown-mode . (lambda ()
                     ;; (flymake-harper-setup)
                     (eldoc-mode 1)
                     (eglot-ensure))))

(use-package mermaid-mode
  :ensure t
  :defer t)

(use-package ob-mermaid
  :ensure t
  :defer t)

(provide 'doc-md)
