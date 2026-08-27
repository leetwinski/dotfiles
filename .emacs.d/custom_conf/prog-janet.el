
(use-package ob-janet
  :ensure t
  :after org
  :config
  (add-to-list 'org-babel-load-languages '(janet . t)))

(use-package janet-mode
  :ensure t
  :hook (janet-mode . (lambda ()
                        (paredit-mode)
                        (eldoc-mode +1))))

(straight-use-package
 '(ajrepl :host github
          :repo "sogaiu/ajrepl"
          :files ("*.el" "ajrepl")))

(use-package ajrepl
  :straight t
  :hook (ajrepl . (lambda () (paredit-mode)))
  :bind
  ("M-RET" . comint-send-input)
  :config
  (add-hook 'janet-mode-hook
            #'ajrepl-interaction-mode))

(provide 'prog-janet)
