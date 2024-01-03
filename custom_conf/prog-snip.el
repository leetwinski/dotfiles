(use-package yasnippet
  :ensure t
  :defer t
  :hook
  (prog-mode . (lambda ()
                 (yas-minor-mode t))))

(use-package yasnippet-snippets :ensure t :after yasnippet)
(use-package clojure-snippets :ensure t :after yasnippet)
(use-package common-lisp-snippets :ensure t :after yasnippet)
(use-package go-snippets :ensure t :after yasnippet)
(use-package java-snippets :ensure t :after yasnippet)
(use-package license-snippets :ensure t :after yasnippet)

(use-package consult-yasnippet
  :ensure t
  :defer t
  :bind
  (:map search-map
        ("y" . consult-yasnippet)))

(provide 'prog-snip)
