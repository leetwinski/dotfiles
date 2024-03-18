(use-package tabnine
  :ensure t
  :commands (tabnine-start-process)
  ;; :hook (prog-mode . tabnine-mode)
  :diminish "⌬"
  :custom
  (tabnine-wait 1)
  (tabnine-minimum-prefix-length 0)
  ;; (tabnine-overlay-face '((t (:inherit shadow :foreground "yellow4"))))
  :hook (kill-emacs . tabnine-kill-process)
  :config
  (add-to-list 'completion-at-point-functions #'tabnine-completion-at-point)
  (tabnine-start-process)
  :bind
  ("C-c 9" . tabnine-mode)
  ("C-c C-M-i" . tabnine-complete)
  :bind
  (:map tabnine-completion-map
	    ("C-TAB" . tabnine-accept-completion)
	    ("M-f" . tabnine-accept-completion-by-word)
	    ("M-RET" . tabnine-accept-completion-by-line)
	    ("C-g" . tabnine-clear-overlay)
	    ("M-[" . tabnine-previous-completion)
	    ("M-]" . tabnine-next-completion)))

(use-package starhugger
  :ensure t
  :custom
  (starhugger-api-token "irrelevant")
  ;; Use https://huggingface.co/bigcode/starcoderplus instead
  (starhugger-model-api-endpoint-url
   "https://api-inference.huggingface.co/models/bigcode/starcoderplus")
  :bind
  ;; ("C-c C-M-i" . starhugger-trigger-suggestion)
  )

(provide 'ai)
