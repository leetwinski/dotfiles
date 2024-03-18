(defun project-tmux-maybe-new-window (dir)
  "Open project in new tmux window, or raise if exists."
  (interactive (list (project-prompt-project-dir)))
  (let* ((pname (concat (file-name-nondirectory (directory-file-name dir))))
         (project-win (string-trim
                       (shell-command-to-string
                        (format "tmux list-windows -F '#I #W' | grep -m 1 '\\[p\\]%s$' | awk '{print $1}'"
                                pname)))))
    (if (string-empty-p project-win)
        (shell-command (format "tmux new-window -n '[p]%s' emacsclient -nw -c '%s'"
                               pname
                               dir))
      (shell-command (format "tmux select-window -t '%s'" project-win)))))

(use-package project
  :ensure t
  :custom
  (project-switch-commands '((project-find-file "File")
                             (project-find-dir "Dir")
                             (project-find-regexp "Regexp")
                             (project-magit-or-vc-dir "VC")
                             (project-eshell "Eshell")))
  :bind
  (:map project-other-frame-map
        ("_" . project-tmux-maybe-new-window)))

(cl-defmethod project-root ((project string))
  project)

(defun local/project-try-explicit (dir)
  "Find a super-directory of DIR containing a root file."
  (locate-dominating-file dir ".root"))

(add-hook 'project-find-functions
	      #'local/project-try-explicit)

(use-package ibuffer-project
  :ensure t
  :defer t
  :after (ibuffer project)
  :hook
  (ibuffer . (lambda ()
               (setq ibuffer-filter-groups (ibuffer-project-generate-filter-groups))
               (unless (eq ibuffer-sorting-mode 'project-file-relative)
                 (ibuffer-do-sort-by-project-file-relative)))))

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
        ("!" . eglot-code-actions)
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
  ;; (set-face-attribute 'eglot-highlight-symbol-face nil :underline t)
  (add-to-list 'eglot-server-programs
               `(jsonian-mode . ,(eglot-alternatives '(("vscode-json-language-server" "--stdio")
                                                       ("vscode-json-languageserver" "--stdio")
                                                       ("json-languageserver" "--stdio")))))
  )

(use-package flymake
  :ensure t
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
(add-hook 'prog-mode-hook #'prettify-symbols-mode)

(use-package ws-butler
  :ensure t
  :init
  (ws-butler-global-mode t))

(use-package tree-sitter-langs
  :ensure t
  :defer t
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
                  do (copy-file src-file dest-file))))))

(use-package hideshow
  :ensure t
  :defer t
  :init
  (defvar hs-map (make-sparse-keymap))

  :hook
  (prog-mode . (lambda () (hs-minor-mode 1)))

  :bind-keymap
  ("C-c =" . hs-map)
  :bind
  ("C-c C-/" . hs-toggle-hiding)
  ("C-c C-_" . hs-toggle-hiding)
  ("C-c M--" . hs-hide-all)
  ("C-c M-=" . hs-show-all)
  (:map hs-map
        ("-" . hs-hide-block)
        ("+" . hs-show-block)
        ("M--" . hs-hide-all)
        ("M-=" . hs-show-all)
        ("l" . hs-hide-level)
        ("=" . hs-toggle-hiding)
        ("a" . hs-show-all)
        ("n" . hs-hide-all)))

(use-package electric
  :ensure t
  :hook (prog-mode . electric-pair-mode))

(use-package tree-sitter
  :ensure t
  :defer t
  :init
  (global-tree-sitter-mode t)
  (add-to-list 'tree-sitter-major-mode-language-alist '(web-mode . html)))

(use-package string-inflection
  :ensure t
  :defer t
  :init
  (defvar string-inflection-keymap (make-sparse-keymap))
  :bind-keymap
  ("C-c ," . string-inflection-keymap)
  :bind
  (:map string-inflection-keymap
        ("," . string-inflection-all-cycle)
        ("-" . string-inflection-lisp)
        ("_" . string-inflection-underscore)
        ("^" . string-inflection-upcase)
        ("+" . string-inflection-camelcase)
        ("=" . string-inflection-lower-camelcase)))

(use-package surround
  :ensure t
  :defer t
  :bind-keymap
  ("C-c s" . surround-keymap))

(defun insert-semi-at-eol ()
  (interactive)
  (call-interactively 'move-end-of-line)
  (insert ";\n")
  (call-interactively 'indent-for-tab-command))

(defun insert-empty-line-and-go ()
  (interactive)
  (call-interactively 'move-end-of-line)
  (call-interactively 'default-indent-new-line)
  (call-interactively 'indent-for-tab-command))

(define-key prog-mode-map (kbd "C-c ;") 'insert-semi-at-eol)
(define-key prog-mode-map (kbd "C-c RET") 'insert-empty-line-and-go)

(use-package rfc-mode
  :ensure t)


;; (use-package puni
;;   :ensure t
;;   :defer t
;;   :hook
;;   (prog-mode . (lambda ()
;;                  ;; exclude puni for lisp modes. use paredit instead
;;                  (unless (seq-some #'derived-mode-p
;;                                    '(lisp-mode
;;                                      common-lisp-mode
;;                                      emacs-lisp-mode
;;                                      clojure-mode))
;;                    (puni-mode +1)))))

(provide 'prog-all)
