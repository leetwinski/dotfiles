

(use-package paredit
  :ensure t
  :hook
  (lisp-mode . (lambda () (paredit-mode 1)))
  (common-lisp-mode-hook . (lambda () (paredit-mode 1)))
  :config
  (define-key paredit-mode-map (kbd "M-?") nil)
  (define-key paredit-mode-map (kbd "M-s") nil)
  :bind
  (:map paredit-mode-map
        ("C-M-?" . paredit-convolute-sexp)
        ("M-U" . paredit-splice-sexp)))

(use-package elisp-mode
  :hook
  (emacs-lisp-mode . (lambda () (paredit-mode 1))))

(defun slime-hook ()
  "My slime hook."
  (subword-mode t)
  (eldoc-mode t)
  (paredit-mode t)
  ;; (rainbow-delimiters-mode-enable)
  )

(defun slime-mrepl-hook ()
  (slime-hook)
  (bind-key "M-RET" 'sly-mrepl-return 'sly-mrepl-mode-map))

(use-package sly
  :ensure t
  :defer t
  :commands (sly sly-start)
  :bind
  (("C-c C-S-p" . sly-pprint-eval-last-expression))
  :hook
  (sly-mode . slime-hook)
  (sly-mrepl-mode . slime-mrepl-hook)
  :init
  (add-hook 'sly-mode-hook #'slime-hook)
  (add-hook 'sly-mrepl-mode-hook #'slime-mrepl-hook)
  (setf sly-lisp-implementations
        '((sbcl    ("sbcl" "--dynamic-space-size" "2000"))
          (roswell ("ros" "dynamic-space-size=2000" "-Q" "-l" "~/.sbclrc" "run"))))
  (setf sly-default-lisp 'roswell)
  (setf inferior-lisp-program "ros -L sbcl -Q -l ~/.sbclrc run"))

(defun sly-qlot-exec (directory)
  (interactive (list (read-directory-name "Project directory: ")))
  (sly-start :program "qlot"
             :program-args '("exec" "ros" "-S" "." "run")
             :directory directory
             :name 'qlot
             :env (list (concat "PATH=" (mapconcat 'identity exec-path ":")))))

(use-package common-lisp-mode
  :defer t
  :mode "\\.\\(lisp|cl\\)\\'")

(provide 'prog-lisp)
