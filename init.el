(require 'package)

(setf use-package-verbose t)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

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
                     prog-data-formats
                     prog-nix
                     doc-md
                     infra-docker
                     communication
                     org-stuff
                     ai))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f87f74ecd2ff6dc433fb4af4e76d19342ea4c50e4cd6c265b712083609c9b567" default))
 '(package-selected-packages
   '(string-inflection phi-search drag-stuff ligature org-babel org-roam elfeed consult-notmuch notmuch telega groovy-mode eglot toml-mode csv-mode vundo flyspell-correct consult-flyspell golden-ratio doom-themes diredfl treemacs-nerd-icons kotlin-mode docker dockerfile-mode docker-file-mode racket-mode project-treemacs treemacs-magit nerd-icons-ibuffer nerd-icons-dired eglot-java java-mode julia-snail julia-mode company-quickhelp emmet-mode pretty-mode xterm-color dired-filter dired-efap cargo-mode wgrep consult-ag expand-region consult-dir page-break-lines starhugger tabnine popper tree-sitter-langs tree-sitter consult-yasnippet yasnippet-snippets yasnippets sly common-lisp-mode clj-refactor sotclojure cider ws-butler doom-modeline embark-consult rainbow-delimiters raindow-delimiters company-mode consult-company consult-project-extra avy exec-path-from-shell typescript-mode magit paredit vertico-prescient prescient marginalia vertico consult no-clown-fiesta-theme leaf)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-diff-removed-highlight ((((type tty)) (:background "gray29")))))
