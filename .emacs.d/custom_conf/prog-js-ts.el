(use-package typescript-mode
  :ensure t
  :defer t
  :mode "\\.tsx?\\'"
  :hook
  (typescript-ts-mode . (lambda ()
                          (eglot-ensure)
                          (eldoc-mode +1)
                          (setq-local fill-column 100)
                          (setq-local compile-command "tsc")))
  (typescript-mode . (lambda ()
                       (eglot-ensure)
                       (eldoc-mode +1)
                       (setq-local fill-column 100)
                       (setq-local compile-command "tsc"))))

;; (dolist (hook '(typescript-mode-hook typescript-ts-mode-hook))
;;   (add-hook hook (lambda () (setq-local fill-column 100))))

;; (use-package typescript-ts-mode
;;   :defer t
;;   :ensure t
;;   :mode "\\.tsx?\\'"
;;   ;; :hook
;;   ;; (typescript-ts-mode . (lambda ()
;;   ;;                      (eglot-ensure)
;;   ;;                      (eldoc-mode +1)
;;   ;;                      (setq compile-command "tsc")))
;;   )

;; (use-package js-ts-mode
;;   :defer t
;;   :mode "\\.jsx?\\'"
;;   :hook
;;   (js-ts-mode . (lambda ()
;;                     (eglot-ensure)
;;                     (eldoc-mode +1))))

(use-package js2-mode
  :ensure t
  :defer t
  :hook
  (js-mode . (lambda () (js2-minor-mode 1))))

(use-package nodejs-repl
  :ensure t
  :defer t)

(add-hook 'js-mode-hook (lambda ()
                          (eglot-ensure)
                          (eldoc-mode +1)
                          (nodejs-repl-minor-mode t)
                          (setq-local fill-column 100)))

(provide 'prog-js-ts)
