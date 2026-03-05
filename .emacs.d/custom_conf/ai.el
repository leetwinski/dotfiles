(use-package password-store
  :ensure t
  :defer t)

(defun set-aider-envs (data)
  (cl-loop for (name val) in data
           do (setenv (concat "AIDER_" (upcase (string-replace "-" "_" name)))
                      (cl-case val
                        ((t) "True")
                        ((nil) "False")
                        (otherwise val)))))

(use-package aidermacs
  ;; :bind (("C-c a" . aidermacs-transient-menu))
  :custom
  (aidermacs-default-model "sonnet")
  (aidermacs-default-chat-mode 'architect)
  ;; (aidermacs-backend 'comint)
  (aidermacs-backend 'vterm)
  ;; (aidermacs-vterm-theme-background-colors-plist
  ;;  '("--completion-menu-bg-color" "#aa4444"
  ;;    "--completion-menu-current-bg-color" highlight))
  ;; (aidermacs-comint-multiline-newline-key "C-<return>")
  (aidermacs-vterm-multiline-newline-key "C-<return>")
  (aidermacs-vterm-use-theme-colors nil)

  (aidermacs-auto-commits nil)
  :hook
  (aidermacs-before-run-backend . (lambda ()
                                    (set-aider-envs '(("analytics-disable" t)
                                                      ("restore-chat-history" t)
                                                      ("analytics" nil)
                                                      ("auto-commits" nil)
                                                      ("dark-mode" t)
                                                      ("auto-lint" t)
                                                      ("show-diffs" t)
                                                      ("auto-accept_architect" t)))
                                    (setenv "ANTHROPIC_API_KEY"
                                            (password-store-get
                                             "code/anthropic_api_key"))
                                    (setenv "OPENAI_API_KEY"
                                            (password-store-get
                                             "code/cody-api-key")))))


(provide 'ai)
