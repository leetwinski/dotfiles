;;; -*- lexical-binding: t; -*-

(use-package julia-mode
  :ensure t
  :defer t
  :mode "\\.jl\\'")

;; (use-package julia-ts-mode
;;   :ensure t
;;   :defer t
;;   :mode "\\.jl\\'")

(use-package julia-snail
  :ensure t
  :defer t
  :init
  (setf julia-snail-multimedia-enable t)
  (setf julia-snail-multimedia-buffer-autoswitch t)
  :custom
  ;; (julia-snail-extensions '(ob-julia))
  (julia-snail-multimedia-enable t)
  (julia-snail-multimedia-buffer-autoswitch t)
  ;; (julia-snail/ob-julia-capture-io nil)
  :hook (julia-mode . (lambda ()
                        (julia-snail-mode 1)
                        (eldoc-mode +1))))

(use-package julia-vterm
  :ensure t
  :defer t)

(use-package ob-julia-vterm
  :ensure t
  :defer t
  :config
  (add-to-list 'org-babel-load-languages '(julia-vterm . t))
  (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages))

;; Load ob-ess-julia and dependencies
;; (use-package ob-ess-julia
;;   :ensure t
;;   :config
;;   ;; Add ess-julia into supported languages:
;;   (org-babel-do-load-languages 'org-babel-load-languages
;;                                (append org-babel-load-languages
;;                                        '((ess-julia . t))))
;;   ;; Link this language to ess-julia-mode (although it should be done by default):
;;   (setq org-src-lang-modes
;;         (append org-src-lang-modes '(("ess-julia" . ess-julia)))))

;; (use-package eglot-jl
;;   :ensure t
;;   :after (julia-mode)
;;   :config
;;   (setf eglot-connect-timeout 300)
;;   :init
;;   (eglot-jl-init)
;;   :hook
;;   (julia-mode . eglot-ensure))

(provide 'prog-julia)
