(use-package org-roam
  :ensure t
  :defer t
  :config
  (org-roam-db-autosync-mode +1))

(use-package poly-org
  :ensure t
  :defer t
  :hook (org-mode . (lambda () (poly-org-mode t))))

(defun flycheck-buffer-not-indirect-p (&rest _)
  "Ensure that the current buffer is not indirect."
  (null (buffer-base-buffer)))

(advice-add 'flycheck-may-check-automatically
            :before-while #'flycheck-buffer-not-indirect-p)

(use-package ob-restclient
  :ensure t
  :defer t)

(use-package ob-go
  :ensure t
  :defer t)

(add-hook 'org-mode-hook (lambda ()
                           (yas-minor-mode t)
                           ;; org-babel settings
                           (setf org-babel-lisp-eval-fn 'sly-eval)
                           (org-babel-do-load-languages
                            'org-babel-load-languages
                            '((lisp . t)
                              (clojure . t)
                              (shell . t)
                              (js . t)
                              (C . t)
                              (go . t)
                              (restclient . t)
                              (julia . t)
                              (python . t)
                              ))))



(provide 'org-stuff)
