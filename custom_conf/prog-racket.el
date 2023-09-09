(use-package racket-mode
  :ensure t
  :defer t
  :mode "\\.rkt\\'"
  :hook
  (racket-mode . (lambda ()
                   (racket-xp-mode t)
                   (eglot-ensure)
                   (eldoc-mode +1))))

(provide 'prog-racket)
