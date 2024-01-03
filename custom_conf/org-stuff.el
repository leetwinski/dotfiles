(use-package org-roam
  :ensure t
  :defer t
  :config
  (org-roam-db-autosync-mode +1))

(add-hook 'org-mode-hook (lambda ()
                           (yas-minor-mode t)
                           ;; org-babel settings
                           (setf org-babel-lisp-eval-fn 'sly-eval)
                           (org-babel-do-load-languages
                            'org-babel-load-languages
                            '((lisp . t)
                              (clojure . t)
                              (shell . t)
                              (julia . t)))))

(provide 'org-stuff)
