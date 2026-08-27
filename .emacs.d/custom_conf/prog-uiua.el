(use-package uiua-mode
  :ensure t
  :defer t
  :mode "\\.ua\\'"
  :init
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '((uiua-mode uiua-ts-mode) . ("uiua" "lsp"))))
  :config (require 'uiua-input)
  :hook
  (uiua-mode . (lambda ()
                 (eldoc-mode 1)
                 (eglot-ensure)
                 (set-input-method "uiua"))))

(provide 'prog-uiua)
