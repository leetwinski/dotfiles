(use-package password-store
  :ensure t)

(use-package aidermacs
  :bind (("C-c a" . aidermacs-transient-menu))
  :custom
  (aidermacs-use-architect-mode t)
  (aidermacs-default-model "sonnet")

  :hook
  (aidermacs-before-run-backend . (lambda ()
                                    (setenv "ANTHROPIC_API_KEY"
                                            (password-store-get
                                             "code/anthropic_api_key")))))

(provide 'ai)
