(use-package typescript-mode
  :ensure t
  :defer t
  :mode "\\.tsx?\\'"
  :hook
  (typescript-mode . (lambda ()
                       (eglot-ensure)
                       (eldoc-mode +1)
                       (setq compile-command "tsc"))))

(provide 'prog-ts)
