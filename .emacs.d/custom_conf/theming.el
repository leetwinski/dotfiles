;; theming

(use-package beacon
  :ensure t
  :init
  (beacon-mode t)
  :config
  (beacon-mode t)
  (add-to-list 'beacon-dont-blink-predicates
               (lambda () (company--active-p)))
  :bind
  ("M-]" . beacon-blink)
  :custom
  (beacon-size 60)
  (beacon-blink-duration 0.2)
  (beacon-blink-delay 0.1)
  (beacon-color "dodgerblue4"))

;; (use-package no-clown-fiesta-theme
;;   :ensure t
;;   :init
;;   (load-theme 'no-clown-fiesta t))

;; (load-theme 'modus-vivendi t)

;; (add-hook 'after-init-hook (lambda ()
;;                              (global-hl-line-mode)
;;                              (set-face-attribute 'hl-line nil :background nil :underline t :foreground nil :extend t)
;;                              ;; (set-face-attribute 'hl-line nil
;;                              ;;                     :background "grey14"
;;                              ;;                     :underline nil
;;                              ;;                     :inverse-video nil
;;                              ;;                     :extend t :foreground nil)
;;                              ))

;; (add-hook 'vterm-mode-hook (lambda ()
;;                              (hl-line-mode nil)))

(load-theme 'modus-vivendi t)

;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t       ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t
;;         )                              ; if nil, italics is universally disabled
;;   ;; (load-theme 'doom-miramare t)

;;   ;; (load-theme 'doom-feather-dark t)
;;   ;; (set-face-background 'vertical-border nil)

;;   ;; (load-theme 'doom-rouge t)
;;   ;; (load-theme 'doom-meltbus t)
;;   ;; (load-theme 'doom-material-dark t)
;;   ;; this is the theme


;;   ;; (load-theme 'doom-tomorrow-night t)
;;   ;; (load-theme 'doom-sourcerer t) <--

;;   ;; -----------------
;;   ;; (load-theme 'doom-plain-dark t)
;;   ;; (load-theme 'doom-sourcerer t)
;;   ;; (load-theme 'doom-badger t)
;;   ;; (load-theme 'doom-pine t)
;;   ;; (load-theme 'doom-lantern t)

;;   ;; (set-face-foreground 'vertical-border "grey48")

;;   ;; (set-face-attribute 'magit-section-heading nil
;;   ;;                     :foreground "#3af"
;;   ;;                     :underline nil)

;;   ;; (set-face-attribute 'region nil
;;   ;;                     :inverse-video nil
;;   ;;                     :background "grey20"
;;   ;;                     :foreground "#f8b0b0")

;;   ;; (set-face-attribute 'magit-diff-hunk-region nil
;;   ;;                     :background "grey20")


;;   ;; (set-face-background 'default "black")

;;   ;; Enable flashing mode-line on errors
;;   ;; (doom-themes-visual-bell-config)
;;   ;; or for treemacs users
;;   ;; (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
;;   ;; (doom-themes-treemacs-config)
;;   ;; Corrects (and improves) org-mode's native fontification.

;;   (doom-themes-org-config)

;;   )

;; (load-theme 'modus-vivendi-tritanopia t)

(set-variable 'frame-background-mode 'dark)

(defun new-frame-fn ()
  (set-face-attribute 'default nil :font "FiraCode Nerd Font Mono Light" :height 112
                      )
  ;; (add-hook 'vterm-mode-hook
  ;;           (lambda ()
  ;;             (set (make-local-variable 'buffer-face-mode-face) )
  ;;             (buffer-face-mode t)))
  (set-mouse-color "LightSteelBlue3")
  (set-background-color "grey12"))

(new-frame-fn)

(add-hook 'server-after-make-frame-hook
          #'new-frame-fn)
;; (set-face-attribute 'default nil :font "FiraCode Nerd Font Mono 17")
;; (set-frame-font (font-spec :family "FiraCode Nerd Font Mono"
;;                            :size 24
;;                            :weight 'semilight))
(use-package doom-modeline
  :ensure t
  :defer t
  :config
  (defsubst doom-modeline--drag-stuff ()
    "Show the number of multiple cursors."
    (when (bound-and-true-p drag-stuff-mode)
      (propertize "󰹹"
                  'face (doom-modeline-face 'doom-modeline-panel))))

  (doom-modeline-def-segment drag-stuff
    "Display buffer size."
    (doom-modeline--drag-stuff))

  (doom-modeline-def-modeline 'main
    '(eldoc bar window-state workspace-name window-number modals drag-stuff matches follow buffer-info remote-host buffer-position word-count parrot selection-info)
    '(compilation objed-state misc-info project-name persp-name battery grip irc mu4e gnus github debug repl lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs check time))

  :commands (doom-modeline-mode)
  :hook (after-init . (lambda () (doom-modeline-mode 1))))

(use-package nerd-icons
  :defer t
  :ensure t)

(use-package nerd-icons-ibuffer
  :ensure t
  :defer t
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(use-package nerd-icons-xref
  :ensure t
  :defer t
  :init
  (nerd-icons-xref-mode))

(use-package nerd-icons-completion
  :ensure t
  :defer t
  :config
  (nerd-icons-completion-mode))

(use-package nerd-icons-grep
  :ensure t
  :defer t
  :init
  (nerd-icons-grep-mode)
  :custom
  (grep-use-headings t))


;; (use-package compile-multi-nerd-icons
;;   :ensure t
;;   :after nerd-icons-completion
;;   :after compile-multi
;;   :demand t)

(use-package ligature
  :ensure t
  :defer t
  :hook (after-init . (lambda () (global-ligature-mode t)))
  :config
  ;; Enable the www ligature in every possible major mode
  (ligature-set-ligatures t '("www"))

  ;; Enable ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-" "::"
                                       ":::" ":=" "!!" "!=" "!==" "-}" "----" "-->" "->" "->>"
                                       "-<" "-<<" "-~" "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
                                       "#_(" ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*" "/**"
                                       "/=" "/==" "/>" "//" "///" "&&" "||" "||=" "|=" "|>" "^=" "$>"
                                       "++" "+++" "+>" "=:=" "==" "===" "==>" "=>" "=>>" "<="
                                       "=<<" "=/=" ">-" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<*"
                                       "<*>" "<|" "<|>" "<$" "<$>" "<!--" "<-" "<--" "<->" "<+"
                                       "<+>" "<=" "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<"
                                       "<~" "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))
  ;; (global-ligature-mode t)
  )

(use-package colorful-mode
  :ensure t
  :defer t
  ;; :config
  :hook (after-init . (lambda () (global-colorful-mode 1))))

(use-package breadcrumb
  :ensure t
  :defer t
  :hook (after-init . (lambda () (breadcrumb-mode t)))
  ;; :config
  ;; (breadcrumb-mode t)
  ;; (set-face-attribute 'breadcrumb-face nil :foreground "gray70" :background nil)
  )

;; (use-package all-the-icons
;;   :ensure t)

;; (use-package all-the-icons-dired
;;   :ensure t
;;   :hook
;;   (dired-mode . all-the-icons-dired-mode))

;; (use-package all-the-icons-ibuffer
;;   :ensure t
;;   :hook (ibuffer-mode . all-the-icons-ibuffer-mode))

(defun complete-ediff-and-exit ()
  (interactive)
  (ediff-quit t)
  (save-buffers-kill-terminal))

(use-package ediff
  :bind
  (:map ediff-mode-map
        ("Q" . complete-ediff-and-exit))
  :config
  ;; (let ((yellow-1 "#fce94f") (yellow-2 "#ffd700") (yellow-3 "#c4a000") (yellow-3-5 "#aaaa11") (yellow-4 "#875f00")
  ;;       (orange-1 "#ffaf5f") (orange-2 "#ff8700") (orange-3 "#ff5d17") (orange-4 "#d75f00") (orange-5 "#af5f00")
  ;;       (magenta-1 "#ff7bbb") (magenta-2 "#ff4ea3") (magenta-3 "#ff1f8b")
  ;;       (green-1 "#afff00") (green-2 "#a1db00") (green-3 "#5faf00") (green-4 "#008700") (green-5 "#005f00")
  ;;       (cyan-1 "#87ffff") (cyan-2 "#87d7af") (cyan-3 "#00d7af") (cyan-4 "#00ac8a") (cyan-5 "#5faf87") (cyan-6 "#005f5f") (cyan-7 "#236f73")
  ;;       (blue-1 "#5fafd7") (blue-2 "#1f5bff") (blue-3 "#005f87") (blue-4 "#005faf") (blue-5 "#0000af") (blue-6 "#00005f")
  ;;       (purple-1 "#d18aff") (purple-2 "#af5fff") (purple-3 "#9a08ff") (purple-4 "#6c0099")
  ;;       (red-1 "#ef2929")  (red-2 "#dd0000")  (red-3 "#a40000") (red-4 "#5f0000")
  ;;       (white-1 "#c6c6c6") (white-2 "#c6c6c6") (white-3 "#b2b2b2") (black-1 "#a8a8a8") (black-2 "#8a8a8a")
  ;;       (black-2-5 "#6c6c6c") (black-3 "#4e4e4e") (black-4 "#3a3a3a") (black-5 "#303030") (black-6 "#000000")
  ;;       (LIGHT_BG "#fdfde7") (white-0 "#eeeeee")
  ;;       (green-02 "#5fd700") (green-01 "#d7ff00") (green-0 "#d7ff5f") (green-00 "#d7ff87")
  ;;       (cyan-0 "#d7ffd7")
  ;;       (blue-01 "#c3c9f8") (blue-0 "#afd7ff") (blue-00 "#d7d7ff")
  ;;       (yellow-0 "#ffff87") (yellow-00 "#ffffaf")
  ;;       (purple-0 "#af87ff") (purple-00 "#e6a8df")
  ;;       (red-0 "#ff4b4b") (red-00 "#ffafaf")
  ;;       (magenta-0 "#ffafd7") (magenta-00 "#ffd7ff")
  ;;       (orange-0 "#ffaf87") (orange-00 "#ffd787") (orange-000 "#ffd7af")
  ;;       (linum-dark "#87875f") (linum-light "#d7d7af"))
  ;;   (set-face-attribute 'ediff-current-diff-A t :background green-5 :foreground white-1)
  ;;   (set-face-attribute 'ediff-current-diff-Ancestor t :background green-5 :foreground white-1)
  ;;   (set-face-attribute 'ediff-current-diff-B t :background green-5 :foreground white-1)
  ;;   (set-face-attribute 'ediff-current-diff-C t :background green-5 :foreground white-1)
  ;;   (set-face-attribute 'ediff-fine-diff-A t :background green-4 :foreground white-0 :bold t )
  ;;   (set-face-attribute 'ediff-fine-diff-Ancestor t :background green-4 :foreground white-0 :bold t )
  ;;   (set-face-attribute 'ediff-fine-diff-B t :background green-4 :foreground white-0 :bold t )
  ;;   (set-face-attribute 'ediff-fine-diff-C t :background green-4 :foreground white-0 :bold t )
  ;;   (set-face-attribute 'ediff-even-diff-A t :background black-3 :foreground black-1)
  ;;   (set-face-attribute 'ediff-even-diff-Ancestor t :background black-3 :foreground black-1)
  ;;   (set-face-attribute 'ediff-even-diff-B t :background black-3 :foreground black-1)
  ;;   (set-face-attribute 'ediff-even-diff-C t :background black-3 :foreground black-1)
  ;;   (set-face-attribute 'ediff-odd-diff-A t :background black-3 :foreground black-1)
  ;;   (set-face-attribute 'ediff-odd-diff-Ancestor t :background black-3 :foreground black-1)
  ;;   (set-face-attribute 'ediff-odd-diff-B t :background black-3 :foreground black-1)
  ;;   (set-face-attribute 'ediff-odd-diff-C t :background black-3 :foreground black-1))
  )

(provide 'theming)
