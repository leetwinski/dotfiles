(defun clj-hook ()
  "My clojure hook."
  (eldoc-mode)
  ;; (subword-mode)
  (paredit-mode)
  (rainbow-delimiters-mode-enable)
  (clj-refactor-mode 1)
  (cider-company-enable-fuzzy-completion)
  ;; (speed-of-thought-mode 1)
  ;; (sotclojure-mode t)
  (yas-minor-mode 1) ; for adding require/use/import
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(use-package cider
  :ensure t
  :defer t
  :bind)

(use-package sotclojure
  :ensure t
  :defer t)

(use-package clj-refactor
  :ensure t
  :defer t)

(use-package clojure-mode
  :ensure t
  :defer t
  ;; :bind  (("C-c C-p" . nil))
  :init
  (setq cider-repl-tab-command 'indent-for-tab-command)
  ;; (setq cider-repl-pop-to-buffer-on-connect nil)
  (setq cider-popup-stacktraces t)
  (setq cider-repl-popup-stacktraces t)
  ;; (setq nrepl-buffer-name-show-port t)
  (setq cider-repl-print-length 500)
  (setq cider-hide-special-buffers t)
  (setq cider-buffer-name-separator "-")
  (setq cider-repl-err-face "Arial")
  (setq cider-auto-select-error-buffer t)
  ;; (setq cider-default-cljs-repl
  ;;       "(do (require 'figwheel-sidecar.repl-api)
  ;;            (figwheel-sidecar.repl-api/start-figwheel!)
  ;;            (figwheel-sidecar.repl-api/cljs-repl))")
  (add-to-list 'same-window-buffer-names "*cider*")
  :config
  ;; (sotclojure-turn-on-everywhere)
  (add-hook 'clojure-mode-hook #'clj-hook)
  (add-hook 'cider-mode-hook #'clj-hook)
  ;; (add-hook 'cider-mode-hook #'hugsql-ghosts-install-hook)
  (add-hook 'cider-repl-mode-hook #'clj-hook))

(progn
  (add-to-list 'auto-mode-alist '("\\.clj\\'" . clojure-mode))
  (add-to-list 'auto-mode-alist '("\\.cljs\\'" . clojurescript-mode))
  (add-to-list 'auto-mode-alist '("\\.cljx\\'" . clojurex-mode))
  (add-to-list 'auto-mode-alist '("\\.cljc\\'" . clojurec-mode)))

(provide 'prog-clj)
