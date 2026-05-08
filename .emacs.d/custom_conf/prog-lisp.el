
(use-package paredit
  :ensure t
  :defer t
  :hook
  (lisp-mode . (lambda () (paredit-mode 1)))
  (common-lisp-mode-hook . (lambda () (paredit-mode 1)))
  (lisp-data-mode . (lambda () (paredit-mode 1)))
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
  ;; (subword-mode t)
  (eldoc-mode t)
  (paredit-mode t)
  ;; (rainbow-delimiters-mode-enable)
  )

(defun slime-mrepl-hook ()
  (slime-hook)
  (bind-key "M-RET" 'sly-mrepl-return 'sly-mrepl-mode-map))

(use-package sly-asdf
  :ensure t
  :defer t
  :after sly)

(defvar *sbcl-version* "sbcl-bin/2.6.4")
(defvar *sly-heap-size* 2048)

(defvar *ld-lib-path*
  (concat "LD_LIBRARY_PATH=" (getenv "NIX_LD_LIBRARY_PATH") ":" (getenv "LD_LIBRARY_PATH")))

;; (sb-ext:set-sbcl-source-location "/home/leet/.roswell/src/sbcl-2.6.3")

(defun my/sly-sbcl-setup-sources ()
  (sly-eval-async
      '(cl:prog1
        nil
        (sb-ext:set-sbcl-source-location "/home/leet/.roswell/src/sbcl-2.6.4"))))

(use-package sly
  :ensure t
  :defer t
  :commands (sly sly-start)
  :bind
  (("C-c C-S-p" . sly-pprint-eval-last-expression))
  :hook
  (sly-mode . slime-hook)
  (sly-mrepl-mode . slime-mrepl-hook)
  (sly-connected . my/sly-sbcl-setup-sources)
  :init
  (add-to-list 'sly-contribs 'sly-asdf 'append)
  ;; (add-hook 'sly-mode-hook #'slime-hook)
  ;; (add-hook 'sly-mrepl-mode-hook #'slime-mrepl-hook)
  (setf sly-lisp-implementations
        `((sbcl ("sbcl" "--dynamic-space-size" ,*sly-heap-size*)
                :env (,*ld-lib-path*))
          (roswell ("ros" ,(format "dynamic-space-size=%s" *sly-heap-size*)
                    "-L" ,*sbcl-version* "-Q" "-l" "~/.sbclrc" "run")
                   :env (,*ld-lib-path*))))
  (setf sly-default-lisp 'roswell)
  (setf inferior-lisp-program (format
                               "ros dynamic-space-size=%s -L %s -Q -l ~/.sbclrc run"
                               *sly-heap-size* *sbcl-version*)))

;; (defun sly-make-run (directory)
;;   (interactive (list (read-directory-name "Project directory: ")))
;;   (sly-start :program "make"
;;              :program-args '("run")
;;              :directory directory
;;              :name 'make
;;              :env (list (concat "PATH=" (mapconcat 'identity exec-path ":")))))

(defun sly-qlot-exec (directory)
  (interactive (list (read-directory-name "Project directory: ")))
  (sly-start :program "qlot"
             :program-args (list "exec" "ros" (format "dynamic-space-size=%s" *sly-heap-size*)
                                 "-L" *sbcl-version*
                                 "-l" "~/.sbclrc"
                                 "-l" ".qlot/setup.lisp"
                                 "-S" "."
                                 "run")
             :directory directory
             :name 'qlot
             :env (list (concat "PATH=" (mapconcat 'identity exec-path ":"))
                        *ld-lib-path*)))

(defun sly-quit-all-dbgs ()
  "Quit all sly debug buffers."
  (interactive)
  (dolist (buf (buffer-list))
    (when (string-match-p "\\*sly-db" (buffer-name buf))
      (with-current-buffer buf
        (sly-db-quit)))))

(use-package common-lisp-mode
  :defer t
  :mode "\\.\\(lisp|cl\\)\\'")

(provide 'prog-lisp)
