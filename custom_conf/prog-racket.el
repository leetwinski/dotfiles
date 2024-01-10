(use-package racket-mode
  :ensure t
  :defer t
  :mode "\\.rkt\\'"
  :hook
  (racket-repl-mode . (lambda ()
                        (paredit-mode 1)
                        (eldoc-mode 1)
                        (racket-unicode-input-method-enable)))

  (racket-mode . (lambda ()
                   (prettify-symbols-mode nil)
                   (racket-xp-mode t)
                   (racket-unicode-input-method-enable)
                   (paredit-mode t)
                   (eglot-ensure)
                   (eldoc-mode t))))

(provide 'prog-racket)
