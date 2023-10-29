(use-package telega
  :ensure t
  :defer t
  :custom
  (telega-server-libs-prefix "/usr"))

(use-package notmuch
  :ensure t
  :defer t)

(use-package consult-notmuch
  :defer t
  :ensure t)

(use-package elfeed
  :ensure t
  :defer t
  :custom
  (elfeed-feeds '(("https://news.ycombinator.com/rss" news tech))))

(provide 'communication)
