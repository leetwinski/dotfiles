(use-package sql-mode
  ;; :ensure t
  :defer t
  :mode "\\.sql\\'"
  :hook
  (sql-mode . (lambda ()
                (eglot-ensure)
                (eldoc-mode +1))))

(provide 'prog-sql)
