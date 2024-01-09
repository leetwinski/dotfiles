(require 'package)

(setf use-package-verbose t)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(add-to-list 'load-path "~/.emacs.d/custom_conf/")

(cl-mapc #'require '(base
                     theming
                     fileman
                     windows
                     completion
                     prog-all
                     prog-snip
                     prog-vc
                     prog-lisp
                     prog-clj
                     prog-js-ts
                     prog-rust
                     prog-web
                     prog-julia
                     prog-java
                     prog-racket
                     prog-kotlin
                     prog-zig
                     prog-go
                     prog-c
                     prog-data-formats
                     prog-nix
                     prog-ocaml
                     doc-md
                     infra-docker
                     communication
                     org-stuff
                     ai))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-diff-removed-highlight ((((type tty)) (:background "gray29"))))
 '(mode-line-inactive ((((type tty)) (:background "color-236")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
