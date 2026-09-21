;;; -*- lexical-binding: t; -*-

(use-package racket-mode
  :ensure t
  :defer t
  :mode "\\.rkt\\'"
  :config
  (unbind-key "C-M-y" racket-mode-map)
  :hook
  (racket-repl-mode . (lambda ()
                        ;; (paredit-mode 1)
                        (puni-mode +1)
                        (eldoc-mode 1)
                        (racket-unicode-input-method-enable)))

  (racket-mode . (lambda ()
                   (prettify-symbols-mode nil)
                   (racket-xp-mode t)
                   (racket-unicode-input-method-enable)
                   ;; (paredit-mode t)
                   (puni-mode +1)
                   (eglot-ensure)
                   (eldoc-mode t)))

  (racket-ts-mode . (lambda ()
                      (prettify-symbols-mode nil)
                      (racket-xp-mode t)
                      (racket-unicode-input-method-enable)
                      ;; (paredit-mode t)
                      (eglot-ensure)
                      (puni-mode +1)
                      (eldoc-mode t)))
  :bind
  (:map racket-repl-mode-map
        ("M-RET" . racket-repl-submit)))

(provide 'prog-racket)
