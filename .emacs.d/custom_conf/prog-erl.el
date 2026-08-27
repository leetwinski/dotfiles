(use-package erlang
  :ensure
  :defer
  :hook (erlang-mode . (lambda ()
                         (eldoc-mode 1)
                         (eglot-ensure))))

(use-package lfe-mode
  :ensure
  :defer
  :init (with-eval-after-load 'eglot
          (add-to-list 'eglot-server-programs
                       '(lfe-mode . ("/home/leet/dev/projects/life/lfe-ls/_build/prod/bin/lfe-ls"
                                     "--transport" "tcp" "--port" :autoport))))
  :hook (lfe-mode . (lambda ()
                      (eldoc-mode 1)
                      (eglot-ensure)
                      (paredit-mode)
                      ;; (setq-local eldoc-echo-area-use-multiline-p t)
                      )))

(defvar lfe-mode-syntax-table
    (let ((table (copy-syntax-table lisp-mode-syntax-table)))
      ;; Like scheme we allow [ ... ] as alternate parentheses.
      (modify-syntax-entry ?\[ "(]  " table)
      (modify-syntax-entry ?\] ")[  " table)
      ;; ":" character should be used as punctuation to separate symbols
      (modify-syntax-entry ?: "." table)
      table)
    "Syntax table in use in Lisp Flavoured Erlang mode buffers.")

;; (use-package erlang-ts
;;   :mode ("\\.erl\\'" . erlang-ts-mode)
;;   :defer
;;   :ensure)



(provide 'prog-erl)
