(use-package web-mode
  :ensure t
  :defer t
  :mode "\\.x?html?\\'"
  :config
  (add-to-list 'eglot-server-programs
               `(web-mode . ("vscode-html-language-server" "--stdio")))
  :hook
  (web-mode . (lambda ()
                (eglot-ensure)
                (eldoc-mode +1))))

(use-package emmet-mode
  :ensure t
  :hook
  (web-mode . emmet-mode)
  (html-mode . emmet-mode)
  (css-mode . emmet-mode))

(provide 'prog-web)
