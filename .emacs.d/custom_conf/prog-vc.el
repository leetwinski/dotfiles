(use-package magit
  :ensure t  
  :config 
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  :init
  (defun project-magit-or-vc-dir ()
    "Run VC-Dir in the current project's root."
    (interactive)
    (let ((project-vc-backend (project-try-vc (project-root (project-current t)))))
      (if (eq (cadr project-vc-backend) 'Git)
          (magit (caddr project-vc-backend))
        (project-vc-dir))))
  :bind
  (:map project-prefix-map
        ("v" . project-magit-or-vc-dir))
  :hook
  (magit-mode . (lambda ()
                  (unless (display-graphic-p)
                    (set-face-attribute 'magit-diff-added nil :foreground "#ac9e7a"
                                        :background "grey10")
                    (set-face-attribute 'magit-diff-added-highlight nil
                                        :foreground "#73803a"
                                        :background "grey10")
                    (set-face-attribute 'magit-diff-removed nil :foreground "#a89"
                                        :background "grey10")
                    (set-face-attribute 'magit-diff-removed-highlight nil
                                        :foreground "#a69"
                                        :background "grey10"))))
  ;; :hook
  ;; (git-commit-setup . flyspell-mode)
  )

(provide 'prog-vc)
