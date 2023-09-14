(use-package project
  :ensure t
  :bind-keymap
  ("<f12>" . project-prefix-map))

(use-package eglot
  :init
  (defvar eglot-keymap (make-sparse-keymap))

  :bind-keymap
  ("C-c l" . eglot-keymap)

  :bind
  (:map eglot-keymap
        ("=" . eglot-format-buffer)
        ("r" . eglot-rename)
        ("g d" . eglot-find-declarations)
        ("g i" . eglot-find-implementation)
        ("g t" . eglot-find-typeDefinition)
        ("a a" . eglot-code-actions)
        ("a q" . eglot-code-action-quickfix)
        ("a i" . eglot-code-action-organize-imports)
        ("a -" . eglot-code-action-inline)
        ("a x" . eglot-code-action-extract)
        ("a r" . eglot-code-action-rewrite)
        ("." . consult-eglot-symbols))

  :hook
  (after-save . (lambda ()
                  (ignore-errors (eglot-format-buffer))))
  :custom (eglot-connect-timeout 180)
  :init
  
  :config
  (set-face-attribute 'eglot-highlight-symbol-face nil :underline t)
  ;; (add-to-list 'eglot-server-programs
  ;;              `(jsonian-mode . ,(eglot-alternatives '(("vscode-json-language-server" "--stdio")
  ;;                                                      ("vscode-json-languageserver" "--stdio")
  ;;                                                      ("json-languageserver" "--stdio")))))
  )

(use-package flymake
  :init
  (defvar flymake-keymap (make-sparse-keymap))

  :hook
  (prog-mode . flymake-mode)
  (prog-mode . flyspell-prog-mode)

  :bind-keymap
  ("C-c !" . flymake-keymap)

  :bind
  (:map flymake-keymap
        ("p" . flymake-goto-prev-error)
        ("n" . flymake-goto-next-error)
        ("!" . flymake-show-buffer-diagnostics)
        ("@" . flymake-show-project-diagnostics)))

(use-package consult-eglot
  :ensure t)

(use-package consult-project-extra
  :ensure t
  :bind
  (:map project-prefix-map
        ("SPC" . consult-project-extra-find)
        ("4 SPC" . consult-project-extra-find-other-window)))

(use-package rainbow-delimiters
  :ensure t
  :hook
  (prog-mode . rainbow-delimiters-mode))

(add-hook 'prog-mode-hook #'subword-mode)

(use-package ws-butler
  :ensure t
  :init
  (ws-butler-global-mode t))

(use-package tree-sitter
  :ensure t)

(use-package tree-sitter-langs
  :ensure t
  :config
  (defun copy-tree-sitter-langs ()
    (interactive)
    (let ((dest "~/.emacs.d/tree-sitter"))
      (delete-directory dest t)
      (make-directory "~/.emacs.d/tree-sitter")
      (when-let (dir (car (directory-files "~/.emacs.d/elpa" t ".*tree-sitter-langs.*")))
        (cl-loop  with src = (expand-file-name "bin" dir)
                  for f in (directory-files src nil ".*\\.so$")
                  for src-file = (expand-file-name f src)
                  for dest-file = (expand-file-name (concat "libtree-sitter-" f) dest)
                  do (princ (format "copying %s to %s\n" src-file dest-file))
                  do (copy-file src-file dest-file)))))
  :defer t)

(use-package hideshow
  :ensure t

  :init
  (defvar hs-map (make-sparse-keymap))

  :hook
  (prog-mode . (lambda () (hs-minor-mode 1)))

  :bind-keymap
  ("C-c C-/" . hs-map)

  :bind
  (:map hs-map
        ("C-h" . hs-hide-block)
        ("C-s" . hs-show-block)
        ("C-M-h" . hs-hide-all)
        ("C-M-s" . hs-show-all)
        ("C-l" . hs-hide-level)
        ("C-c" . hs-toggle-hiding)
        ("C-a" . hs-show-all)
        ("C-t" . hs-hide-all)
        ("C-d" . hs-hide-block)
        ("C-e" . hs-toggle-hiding)))

(use-package pretty-mode
  :ensure t
  :hook (prog-mode . turn-on-pretty-mode))

(use-package electric
  :ensure t
  :hook (prog-mode . electric-pair-mode))

(use-package tree-sitter
  :ensure t
  :init
  (global-tree-sitter-mode t)
  (add-to-list 'tree-sitter-major-mode-language-alist '(web-mode . html))
  )

(provide 'prog-all)
