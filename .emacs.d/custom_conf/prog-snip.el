(use-package yasnippet
  :ensure t
  :defer t
  :hook
  (prog-mode . (lambda ()
                 (yas-minor-mode t))))

(use-package yasnippet-snippets :ensure t :after yasnippet :defer t)
(use-package clojure-snippets :ensure t :after yasnippet :defer t)
(use-package common-lisp-snippets :ensure t :after yasnippet :defer t)
(use-package go-snippets :ensure t :after yasnippet :defer t)
(use-package java-snippets :ensure t :after yasnippet :defer t)
(use-package license-snippets :ensure t :after yasnippet :defer t)

(use-package consult-yasnippet
  :ensure t
  :defer t
  :bind
  (:map search-map
        ("y" . consult-yasnippet)))

(provide 'prog-snip)
