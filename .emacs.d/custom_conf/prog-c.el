;;; -*- lexical-binding: t; -*-

(use-package c-mode
  :defer t
  :hook
  (c-mode . (lambda ()
              (eldoc-mode 1)
              (eglot-ensure)))
  (c-ts-mode . (lambda ()
                 (eldoc-mode 1)
                 (eglot-ensure))))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((c-mode c-ts-mode)
                 . ("clangd"
                    "--query-driver=/home/leet/.nix-profile/bin/gcc,/nix/store/*-gcc-wrapper-*/bin/gcc,/run/current-system/sw/bin/gcc"
                    "--background-index"
                    "--clang-tidy"
                    "--header-insertion=never"))))

(setq trusted-content '("~/dev/projects/life/"))

(provide 'prog-c)
