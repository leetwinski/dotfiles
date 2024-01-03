;; completion
(use-package consult
  :ensure t
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ("C-c y" . consult-yank-from-kill-ring)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command) ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer) ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame) ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark) ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer) ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store) ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop) ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         :map goto-map
         ("e" . consult-compile-error)
         ("f" . consult-flymake)     ;; Alternative: consult-flycheck
         ("g" . consult-goto-line)   ;; orig. goto-line
         ("M-g" . consult-goto-line) ;; orig. goto-line
         ("o" . consult-outline) ;; Alternative: consult-org-heading
         ("m" . consult-mark)
         ("k" . consult-global-mark)
         ("i" . consult-imenu)
         ("I" . consult-imenu-multi)
         ("d" . consult-dir)
         ("r" . consult-recent-file)
         ;; M-s bindings in `search-map'
         :map search-map
         ("d" . consult-find)
         ("D" . consult-locate)
         ("g" . consult-grep)
         ("G" . consult-git-grep)
         ("s" . consult-ripgrep)
         ("l" . consult-line)
         ("L" . consult-line-multi)
         ("k" . consult-keep-lines)
         ("u" . consult-focus-lines)
         ;; Isearch integration
         ("e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history) ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history) ;; orig. isearch-edit-string
         ("M-s l" . consult-line) ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi) ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history) ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config
  (set-face-attribute 'consult-preview-match nil
                      :background "yellow"
                      :foreground "black"
                      :bold t)
  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  (setq consult-narrow-key "<")

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)
  (setq consult-project-function #'consult--default-project-function))

(use-package consult-dir
  :ensure t
  :bind
  ;; (:map consult-keymap
  ;;       ("d" . consult-dir))
  )

(use-package consult-ag
  :ensure t
  :defer t
  :bind
  (:map search-map
        ("a" . consult-ag)))

(use-package company
  :ensure t
  ;; :config
  :init
  (global-company-mode t)
  (define-key company-mode-map [remap completion-at-point] #'company-complete)
  :init
  :bind ("C-M-i" . company-complete)
  ;; :hook (prog-mode . (lambda () (add-to-list
  ;;                           'completion-at-point-functions
  ;;                           #'company-complete)))
  )

(use-package company-quickhelp
  :ensure t
  :defer t
  :after (company)
  :config
  (company-quickhelp-mode t)
  :bind
  (:map company-active-map
        ("C-c h" . company-quickhelp-manual-begin)))

(use-package consult-company
  :ensure t
  :bind
  (:map search-map
        ("c" . consult-company)))

(use-package embark
  :ensure t
  :config
  (set-face-attribute 'embark-keybinding nil :inherit font-lock-keyword-face)
  :bind
  ("C-c e ." . embark-dwim)
  ("C-c e e" . embark-act)
  ("C-h B" . embark-bindings))

(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package vertico
  :ensure t
  :init
  (vertico-mode t))

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode t)
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle)))

(use-package flyspell-correct
  :ensure t
  :after flyspell
  ;; :bind (:map flyspell-mode-map ("C-;" . flyspell-correct-wrapper))
  )

(use-package consult-flyspell
  :ensure t
  :config
  (setf consult-flyspell-select-function 'flyspell-correct-at-point)
  ;; (setf consult-flyspell-select-function 'flyspell-auto-correct-word)
  :bind
  ("M-$" . consult-flyspell))

(use-package prescient
  :ensure t)

(use-package wgrep
  :ensure t)

(use-package vertico-prescient
  :ensure t
  :after (vertico prescient)
  :config
  (vertico-prescient-mode t))
;; end completion

(provide 'completion)
