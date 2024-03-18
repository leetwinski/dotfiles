(use-package nix-mode
  :ensure t
  :defer t
  :hook
  (nix-mode . (lambda ()
                (eglot-ensure)
                (eldoc-mode +1))))

(add-hook 'nix-repl-mode-hook
          (lambda ()
            ;; Disable font-locking in this buffer to improve performance
            (font-lock-mode -1)
            ;; Prevent font-locking from being re-enabled in this buffer
            (make-local-variable 'font-lock-function)
            (setq font-lock-function (lambda (_) nil))
            (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter nil t)))

(provide 'prog-nix)
