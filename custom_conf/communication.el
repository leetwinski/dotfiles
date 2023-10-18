(use-package telega
  :ensure t
  :custom
  (telega-server-libs-prefix "/usr"))

(use-package notmuch
  :ensure t)

(use-package consult-notmuch
  :ensure t)

(use-package elfeed
  :ensure t
  :custom
  (elfeed-feeds '(("https://news.ycombinator.com/rss" news tech))))

(provide 'communication)
