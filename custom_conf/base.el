(setf inhibit-startup-screen t)

;; Minimize garbage collection during startup
(setf gc-cons-threshold most-positive-fixnum)

(add-hook 'emacs-startup-hook
          (lambda ()
            ;; Lower threshold back to 8 MiB (default is 800kB)
            (setf gc-cons-threshold (expt 2 23))
            (setf delete-by-moving-to-trash t)
            (setq-default tab-width 4)
            (menu-bar-mode -99)
            (tool-bar-mode -1)
            (setf inhibit-startup-screen t)
            (defalias 'yes-or-no-p 'y-or-n-p)
            (setf word-wrap nil)
            (blink-cursor-mode 0)
            (delete-selection-mode t)
            (column-number-mode t)
            (scroll-bar-mode -1)
            (fringe-mode nil)
            (setq-default indent-tabs-mode nil)
            (setf ring-bell-function #'ignore)
            (put 'upcase-region 'disabled nil)
            (put 'downcase-region 'disabled nil)))

(bind-key (kbd "C-c d") #'duplicate-dwim)

(use-package ffap
  :ensure t
  :init (ffap-bindings))

(use-package expand-region
  :ensure t
  :bind
  ("C-c @ @" . er/expand-region)
  ("C-c @ f" . er/mark-defun)
  ("C-c @ ;" . er/mark-comment)
  ("C-c @ ." . er/mark-sentence)
  ("C-c @ m" . er/mark-email)
  ("C-c @ u" . er/mark-url)
  ("C-c @ p" . er/mark-paragraph)
  ("C-c @ w" . er/mark-word)
  ("C-c @ '" . er/mark-inside-quotes)
  ("C-c @ \"" . er/mark-outside-quotes)
  ("C-c @ [" . er/mark-inside-pairs)
  ("C-c @ {" . er/mark-outside-pairs)
  ("C-c @ s" . er/mark-symbol)
  ("C-c @ S" . er/mark-symbol-with-prefix)
  ("C-c @ (" . er/mark-method-call))

(use-package page-break-lines
  :ensure t
  :init (global-page-break-lines-mode t))

(use-package exec-path-from-shell
  :ensure t
  ;; :custom
  ;; (exec-path-from-shell-arguments nil)
  :init
  (exec-path-from-shell-initialize))

(use-package guru-mode
  :ensure t
  :config
  (guru-global-mode t))

(use-package vundo :ensure t
  :config
  (setq vundo-glyph-alist vundo-ascii-symbols)

  :bind
  ("C-c /" . vundo)
  ("C-c _" . vundo))

(use-package recentf
  :ensure t
  :init
  (recentf-mode 1))

(use-package avy
  :ensure t
  :init
  (defvar avy-custom-keymap (make-sparse-keymap))

  :custom (avy-keys '(?1 ?2 ?3 ?4 ?q ?w ?e ?r ?a ?s ?d ?f))
  
  :bind-keymap
  ("C-c a" . avy-custom-keymap)

  :bind
  (:map isearch-mode-map
        ("C-c C-\\ s" . avy-isearch)
        ("C-c C-a s" . avy-isearch))
  (:map avy-custom-keymap
        ;; movement
        ("p" . avy-prev)
        ("n" . avy-next)
        ("a" . avy-resume)
        
        ;; char
        ("c c" . avy-goto-char)
        ("c 2" . avy-goto-char-2)
        
        ;; word
        ("w w" . avy-goto-word-or-subword-1)
        ("w 1" . avy-goto-word-1)
        ("w p" . avy-goto-word-1-above)
        ("w n" . avy-goto-word-1-below)
        ("w 0" . avy-goto-word-0)

        ;; line
        ("l l" . avy-goto-line)
        ("l e" . avy-goto-end-of-line)
        ("l p" . avy-goto-line-above)
        ("l n" . avy-goto-line-below)
        ("l m" . avy-move-line)
        ("l c" . avy-copy-line)
        ("l k" . avy-kill-whole-line)
        ("l w" . avy-kill-ring-save-whole-line)

        ;; region
        ("r m" . avy-move-region)
        ("r c" . avy-copy-region)
        ("r k" . avy-kill-region)
        ("r w" . avy-kill-ring-save-region)

        ;; zap
        ("z p" . avy-zap-up-to-char-dwim)
        ("z n" . avy-zap-to-char-dwim)))

(use-package multiple-cursors
  :ensure t
  :config
  (defvar mc-map (make-sparse-keymap))
  :bind-keymap
  ("C-c #" . mc-map)
  :bind
  (:map search-map
        ("`" . mc/mark-more-like-this-extended))
  (:map mc-map
        ("l l" . mc/edit-lines)
        ("l e" . mc/edit-ends-of-lines)
        ("l n" . mc/mark-next-lines)
        ("l p" . mc/mark-previous-lines)
        ("w w" . mc/mark-all-words-like-this)
        ("w n" . mc/mark-next-word-like-this)
        ("w p" . mc/mark-previous-word-like-this)
        ("w f" . mc/mark-all-words-like-this-in-defun)
        ("s s" . mc/mark-all-symbols-like-this)
        ("s f" . mc/mark-all-symbols-like-this-in-defun)
        ("s n" . mc/mark-next-symbol-like-this)
        ("s p" . mc/mark-previous-symbol-like-this)
        ("*" . mc/mark-all-dwim)
        (". ." . mc/mark-all-like-this-dwim)
        (". ," . mc/mark-all-like-this)
        (". f" . mc/mark-all-like-this-in-defun)
        (". r" . mc/mark-all-in-region)
        (". R" . mc/mark-all-in-region-regexp)
        (">" . mc/mark-sgml-tag-pair)
        ("i n" . mc/insert-numbers)
        ("i l" . mc/insert-letters)))

(use-package ibuffer
  :ensure t
  :bind ("C-x C-b" . ibuffer))

(defun colorize-output ()
  ;; Disable font-locking in this buffer to improve performance
  (font-lock-mode -1)
  ;; Prevent font-locking from being re-enabled in this buffer
  (make-local-variable 'font-lock-function)
  (setq font-lock-function (lambda (_) nil))
  (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter nil t))

(defun my/advice-compilation-filter (f proc string)
  (funcall f proc (xterm-color-filter string)))

(use-package xterm-color
  :ensure t
  :init
  (advice-add 'compilation-filter :around #'my/advice-compilation-filter)
  (advice-add 'magit-process-filter :around #'my/advice-compilation-filter)

  (setf comint-output-filter-functions
        (remove 'ansi-color-process-output comint-output-filter-functions)))

(add-hook 'shell-mode-hook
          (lambda ()
            ;; Disable font-locking in this buffer to improve performance
            (font-lock-mode -1)
            ;; Prevent font-locking from being re-enabled in this buffer
            (make-local-variable 'font-lock-function)
            (setq font-lock-function (lambda (_) nil))
            (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter nil t)))
;; (add-hook 'shell-mode-hook 'colorize-output)
;; (add-hook 'comint-mode-hook 'colorize-output)
;; (add-hook 'magit-process-mode-hook 'colorize-output)

(defun dotemacs ()
  "Open init.el for editing."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(defvar backup-dir (expand-file-name "~/.emacs.d/backup/"))
(setq backup-directory-alist (list (cons ".*" backup-dir)))
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))
(setq tramp-backup-directory-alist backup-directory-alist)
(setq tramp-auto-save-directory autosave-dir)

(global-set-key (kbd "C-c DEL") 'delete-all-space)

(provide 'base)
