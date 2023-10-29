(use-package yasnippet
  :ensure t
  :defer t
  :hook (prog-mode . yas-minor-mode))

(use-package yasnippet-snippets
  :ensure t)

(use-package consult-yasnippet
  :ensure t
  :defer t
  :bind
  (:map search-map
        ("y" . consult-yasnippet)))

(provide 'prog-snip)
