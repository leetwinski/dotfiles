;; (use-package eglot-java
;;   :defer t
;;   :after (java-mode)
;;   :ensure t
;;   ;; :init (add-to-list 'eglot-server-programs
;;   ;;                    `((java-mode ;; java-ts-mode
;;   ;;                                 ) .
;;   ;;                      ("jdtls"
;;   ;;                       "--stdio"
;;   ;;                       ;; :initializationOptions
;;   ;;                       ;; (:bundles ["~/.emacs.d/debug-adapters/java/com.microsoft.java.debug.plugin-0.53.1.jar"])
;;   ;;                       )))
;;   )

(add-hook 'java-ts-mode-hook (lambda ()
                               (eglot-ensure)
                               ;; (eglot-java-mode 1)
                               (eldoc-mode +1)))

(add-hook 'java-mode-hook (lambda ()
                            (eglot-ensure)
                            ;; (eglot-java-mode 1)
                            (eldoc-mode +1)))

(dolist (hook '(java-mode-hook java-ts-mode-hook))
  (add-hook hook (lambda () (setq-local fill-column 100))))


(use-package groovy-mode
  :defer t
  :ensure t)

(provide 'prog-java)
