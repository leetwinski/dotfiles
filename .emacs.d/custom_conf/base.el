(setf inhibit-startup-screen t)
(setf initial-major-mode 'org-mode)
(setf initial-scratch-message nil)

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
            (defalias 'yes-or-no-p 'y-or-n-p)
            (setf word-wrap nil)
            (blink-cursor-mode 0)
            (delete-selection-mode t)
            (column-number-mode t)
            (scroll-bar-mode -1)
            (fringe-mode nil)
            (setq-default indent-tabs-mode nil)
            (setq-default truncate-lines t)
            (setf ring-bell-function #'ignore)
            (put 'upcase-region 'disabled nil)
            (put 'downcase-region 'disabled nil)))

(defun shell-command-on-buffer ()
  "Asks for a command and executes it in inferior shell with current buffer as input."
  (interactive)
  (shell-command-on-region
   (point-min) (point-max)
   (read-shell-command "Shell command on buffer: ")))

(bind-key (kbd "C-c #") #'shell-command-on-buffer)
(bind-key (kbd "C-c d") #'duplicate-dwim)

(use-package ffap
  :ensure t
  :defer t
  :init (ffap-bindings))

;; (use-package expand-region
;;   :ensure t
;;   :init
;;   (defvar expand-region-keymap (make-sparse-keymap))
;;   :bind-keymap
;;   ("C-c ." . expand-region-keymap)
;;   :bind
;;   (:map expand-region-keymap
;;         ("." . er/expand-region)
;;         ("f" . er/mark-defun)
;;         (";" . er/mark-comment)
;;         ("|" . er/mark-sentence)
;;         ("m" . er/mark-email)
;;         ("u" . er/mark-url)
;;         ("p" . er/mark-paragraph)
;;         ("w" . er/mark-word)
;;         ("'" . er/mark-inside-quotes)
;;         ("\"" . er/mark-outside-quotes)
;;         ("[" . er/mark-inside-pairs)
;;         ("{" . er/mark-outside-pairs)
;;         ("s" . er/mark-symbol)
;;         ("S" . er/mark-symbol-with-prefix)
;;         ("(" . er/mark-method-call)))

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
  :defer t
  :config (guru-global-mode t)
  :hook (after-init . (lambda () (guru-global-mode t))))

(use-package vundo :ensure t
  :defer t
  :config
  (setq vundo-glyph-alist vundo-ascii-symbols)

  :bind
  ("C-c /" . vundo)
  ("C-c _" . vundo))

(use-package recentf
  :ensure t
  :defer t
  ;; :hook (after-init . (lambda () (recentf-mode 1)))
  :init
  (recentf-mode 1)
  )

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
        ("r w" . avy-kill-ring-save-region)))

(use-package multiple-cursors
  :ensure t
  :defer t
  :config
  (defvar mc-map (make-sparse-keymap))
  :bind-keymap
  ("C-c |" . mc-map)
  :bind
  (:map search-map
        ("`" . mc/mark-more-like-this-extended)
        ("|" . mc/mark-more-like-this-extended))
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
        ("SPC" . mc/mark-more-like-this-extended)
        ("*" . mc/mark-all-dwim)
        ("|" . mc/mark-all-dwim)
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
  :defer t
  :bind ("C-x M-b" . ibuffer))

(use-package bufferlo
  :ensure t
  :defer t
  :init
  (bufferlo-mode 1)
  :config
  (defvar my-consult--source-local-buffer
    `(:name "Local Buffers"
            :narrow   ?l
            :category buffer
            :face     consult-buffer
            :history  buffer-name-history
            :state    ,#'consult--buffer-state
            :default  t
            :items ,(lambda () (consult--buffer-query
                           :predicate #'bufferlo-local-buffer-p
                           :sort 'visibility
                           :as #'buffer-name)))
    "Local buffer candidate source for `consult-buffer'.")

  (defvar my-consult--source-buffer
    `(:name "Other Buffers"
            :narrow   ?b
            :category buffer
            :face     consult-buffer
            :history  buffer-name-history
            :state    ,#'consult--buffer-state
            :items ,(lambda () (consult--buffer-query
                           :predicate #'bufferlo-non-local-buffer-p
                           :sort 'visibility
                           :as #'buffer-name)))
    "Non-local buffer candidate source for `consult-buffer'.")

  (setq consult-buffer-sources '(consult--source-hidden-buffer
                                 my-consult--source-local-buffer
                                 my-consult--source-buffer
                                 ;; ... other sources ...
                                 )))

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

(global-set-key (kbd "C-c DEL DEL") 'delete-all-space)
(global-set-key (kbd "C-c DEL l") 'kill-whole-line)

(use-package easy-kill
  :ensure t
  :defer t
  :init
  (global-set-key [remap kill-ring-save] 'easy-kill)
  (global-set-key [remap mark-sexp] 'easy-mark))

(global-set-key (kbd "C-c n") 'display-line-numbers-mode)
(global-set-key (kbd "C-M-y") 'up-list)

(setf bookmark-save-flag 1)

(use-package drag-stuff
  :ensure t
  :defer t
  :config
  ;; (drag-stuff-define-keys)
  ;; (drag-stuff-global-mode t)
)

(use-package phi-search
  :ensure t
  :bind
  ("C-s" . phi-search)
  ("C-r" . phi-search-backward)
  ("M-%" . phi-replace-query)
  :config (set-face-attribute 'phi-search-selection-face nil
                              :foreground "black"
                              :background "yellow"
                              :box t
                              :bold t))

;; shadowing file paths, e.g. when ~ is inserted
(setq file-name-shadow-properties '(invisible t intangible t))
(setq file-name-shadow-tty-properties '(invisible t intangible t))
(file-name-shadow-mode +1)
;; -----------

(use-package clipetty
  :ensure t
  :hook (after-init . global-clipetty-mode))

(xterm-mouse-mode t)
(bind-key (kbd "C-c [")  #'vterm-copy-mode)

(use-package tramp
  :config
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
  (setq tramp-auto-save-directory "~/tmp/tramp/")
  (setq tramp-chunksize 2000))


(when (string= (getenv "IS_WSL") "1")
  (setf browse-url-generic-program "wsl-open"))

(bind-key (kbd "M-g w") #'browse-url-generic)

(provide 'base)
