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
                     prog-ts
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
 '(package-selected-packages
   '(poly-org license-snippets java-snippets go-snippets common-lisp-snippets clojure-snippets starhugger tabnine org-roam zig-mode yasnippet-snippets xterm-color ws-butler windresize wgrep web-mode vundo vertico-prescient typescript-mode tuareg treemacs-nerd-icons treemacs-magit toml-mode telega surround string-inflection sotclojure sly rust-mode rainbow-delimiters racket-mode project-treemacs popper phi-search page-break-lines nix-mode nerd-icons-ibuffer nerd-icons-dired markdown-mode marginalia ligature kotlin-mode julia-snail json-mode ibuffer-project guru-mode groovy-mode golden-ratio go-mode flyspell-correct expand-region exec-path-from-shell emmet-mode embark-consult emacsql elfeed eglot-java drag-stuff doom-themes doom-modeline dockerfile-mode docker diredfl dired-filter dired-efap cycle-resize csv-mode consult-yasnippet consult-project-extra consult-notmuch consult-flyspell consult-eglot consult-dir consult-company consult-ag company-quickhelp clj-refactor clipetty cargo-mode bufferlo)))
