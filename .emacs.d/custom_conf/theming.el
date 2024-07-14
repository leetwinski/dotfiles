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
  ;; (load-theme 'doom-miramare t)
  (load-theme 'doom-feather-dark t)
  (set-face-background 'default "black")
  (set-face-background 'vertical-border nil)
  (set-face-foreground 'vertical-border "grey18")
  (set-mouse-color "LightSteelBlue3")

  ;; Enable flashing mode-line on errors
  ;; (doom-themes-visual-bell-config)
  ;; or for treemacs users
  ;; (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  ;; (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
  )

(set-variable 'frame-background-mode 'dark)
(set-face-attribute 'default nil :font "FiraCode Nerd Font Mono" :height 164)
;; (set-face-attribute 'default nil :font "FiraCode Nerd Font Mono 17")
;; (set-frame-font (font-spec :family "FiraCode Nerd Font Mono"
;;                            :size 24
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

(use-package colorful-mode
  :ensure t
  :config
  (global-colorful-mode 1))

(use-package breadcrumb
  :ensure t
  :config
  (breadcrumb-mode t)
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

(provide 'theming)
