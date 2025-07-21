
;; (add-to-list 'load-path "/home/leet/.emacs.d/straight/repos/scel/el")
;; (require 'sclang)

;; ;; (straight-use-package
;; ;;  '(scel1 :type git :host github :repo "supercollider/scel"
;; ;;         :build t
;; ;;         ;; :pre-build ("make" "all")
;; ;;         ))

;; (use-package sclang-snippets
;;   :ensure t)

;; (use-package sclang-extensions
;;   :ensure t)

(use-package processing-mode
  :ensure t
  :defer t
  :config (processing-snippets-initialize))

(use-package processing-snippets
  :ensure t
  :defer t)

(use-package gnuplot
  :ensure t
  :defer t)

(provide 'media)
