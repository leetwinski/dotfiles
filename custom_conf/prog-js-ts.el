(use-package typescript-mode
  :ensure t
  :defer t
  :mode "\\.tsx?\\'"
  :hook
  (typescript-mode . (lambda ()
                       (eglot-ensure)
                       (eldoc-mode +1)
                       (setq compile-command "tsc"))))

(use-package js2-mode
  :ensure t
  :defer t
  :hook
  (js-mode . (lambda () (js2-minor-mode 1))))

(add-hook 'js-mode-hook (lambda ()
                          (eglot-ensure)
                          (eldoc-mode +1)))

(provide 'prog-js-ts)
