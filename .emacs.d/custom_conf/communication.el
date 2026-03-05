(shell-command "nix-instantiate --eval-only --expr '(import <unstable> {}).tdlib.outPath'")


(defun get-tdlib-path ()
  (string-trim
   (cl-remove
    ?\"
    (shell-command-to-string
     "nix-instantiate --eval-only --expr '(import <unstable> {}).tdlib.outPath'"))))

(use-package telega
  :ensure t
  :defer t
  :config
  :custom
  ;; (telega-server-libs-prefix "/usr")
  (telega-video-player-command "xdg-open")
  (telega-server-libs-prefix (get-tdlib-path))
  )

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
  (elfeed-feeds '(("https://news.ycombinator.com/rss" news tech)
                  ("http://planet.clojure.in/atom.xml" clj tech)
                  ("https://planet.lisp.org/rss20.xml" lisp tech)
                  ("https://lisp-journey.gitlab.io/blog/index.xml" lisp tech)
                  ("https://www.reddit.com/r/emacs.rss" emacs reddit tech)
                  ("https://www.reddit.com/r/Julia.rss" julia reddit tech)
                  ("https://xkcd.com/rss.xml" humour)
                  ("http://xahlee.info/emacs/emacs/blog.xml" emacs tech)
                  ("https://www.reddit.com/r/Common_Lisp.rss" lisp reddit tech)
                  ("https://emacsredux.com/atom.xml" emacs tech))))

(provide 'communication)
