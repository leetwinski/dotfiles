;; theming

;; (use-package no-clown-fiesta-theme
;;   :ensure t
;;   :init
;;   (load-theme 'no-clown-fiesta t))

;; (load-theme 'modus-vivendi t)

;; (add-hook 'after-init-hook 'global-hl-line-mode)

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  (load-theme 'doom-miramare t)
  (set-face-background 'vertical-border nil)
  ;; Enable flashing mode-line on errors
  ;; (doom-themes-visual-bell-config)
  ;; or for treemacs users
  ;; (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  ;; (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
  )

;; (when (display-graphic-p)
;;   (invert-face 'default))

(set-variable 'frame-background-mode 'dark)

;; (set-face-attribute 'default nil :font "FiraCode Nerd Font Mono 13")

;; (set-frame-font (font-spec :family "FiraCode Nerd Font Mono"
;;                            :size 17
;;                            :weight 'semilight))

(use-package doom-modeline
  :ensure t
  :defer t
  :commands (doom-modeline-mode)
  :hook (after-init . doom-modeline-mode))

(use-package nerd-icons
  :defer t
  :ensure t)

(use-package nerd-icons-ibuffer
  :ensure t
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(defun set-faces-for-terminal (&optional frame)
  (or frame (setq frame (selected-frame)))
  "sets misc faces in terminal mode"
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)
    (set-face-background 'vterm-color-black "brightblack" frame)
    ;; (set-face-background 'region "gray23" frame)
    (set-face-background 'region "color-53" frame)
    ))

(add-hook 'after-make-frame-functions 'set-faces-for-terminal)

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (select-frame frame)
                (set-face-attribute 'default nil :font "FiraCode Nerd Font Mono Light" :height 154)))
  (set-face-attribute 'default nil :font "FiraCode Nerd Font Mono Light" :height 154))

(use-package ligature
  :ensure t
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
  (global-ligature-mode t))

(custom-set-faces
 ;; other faces
 ;; '(magit-diff-added ((((type tty)) (:foreground "green"))))
 ;; '(magit-diff-added-highlight ((((type tty)) (:foreground "LimeGreen"))))
 ;; '(magit-diff-context-highlight ((((type tty)) (:foreground "default"))))
 ;; '(magit-diff-file-heading ((((type tty)) nil)))
 ;; '(magit-diff-removed ((((type tty)) (:foreground "red"))))
 '(mode-line-inactive ((((type tty))
                        (:background "color-236"))))

 '(mode-line-active ((((type tty))
                        (:background "color-23"))))

 '(magit-diff-removed-highlight ((((type tty))
                                  (:background "gray29"))))
 ;; '(magit-section-highlight ((((type tty)) nil)))
 )

(use-package colorful-mode
  :ensure t
  :config
  (global-colorful-mode 1))

(use-package breadcrumb
  :ensure t
  :config
  (breadcrumb-mode t)
  (set-face-attribute 'breadcrumb-face nil :foreground "gray70"))

;; (use-package all-the-icons
;;   :ensure t)

;; (use-package all-the-icons-dired
;;   :ensure t
;;   :hook
;;   (dired-mode . all-the-icons-dired-mode))

;; (use-package all-the-icons-ibuffer
;;   :ensure t
;;   :hook (ibuffer-mode . all-the-icons-ibuffer-mode))

(provide 'theming)
