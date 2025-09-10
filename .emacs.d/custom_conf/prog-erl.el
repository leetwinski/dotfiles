(use-package erlang
  :ensure
  :defer
  :hook (erlang-mode . (lambda ()
                         (eldoc-mode 1)
                         (eglot-ensure))))

(use-package lfe-mode
  :ensure
  :defer)
;; (use-package erlang-ts
;;   :mode ("\\.erl\\'" . erlang-ts-mode)
;;   :defer
;;   :ensure)



(provide 'prog-erl)
