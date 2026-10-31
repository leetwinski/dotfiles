;;; -*- lexical-binding: t; -*-

(use-package docker
  :ensure t
  :defer t
  :bind ("C-c d" . docker))

(use-package dockerfile-mode
  :ensure t
  :defer t
  :hook
  (dockerfile-mode . (lambda ()
                       (eldoc-mode t)
                       (eglot-ensure)))
  (dockerfile-ts-mode . (lambda ()
                          (eldoc-mode t)
                          (eglot-ensure))))

(use-package terraform-mode
  :ensure t
  :defer t
  :hook
  (terraform-mode . (lambda ()
                      (tree-sitter-mode t)
                      (eglot-ensure)
                      (eldoc-mode +1))))

(provide 'infra-docker)
