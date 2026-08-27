(load "~/.sbclrc")

(setf *read-eval* t)

(in-package :stumpwm-user)
(add-hook stumpwm:*start-hook*
          (lambda ()
            (run-with-timer 2 nil (lambda ()
                                    (stumpwm::update-all-mode-lines)))))

;; (set-prefix-key (kbd "F13"))

(ql:quickload :alexandria)
(use-package :alexandria)

(stumpwm:grename "main")        ; rename default group 1
(stumpwm:gnewbg "chat")         ; new group, don't switch to it
(stumpwm:gnewbg "media")
;; (stumpwm:gnewbg "zoom")
(stumpwm:gnewbg-float "zoom")

;; (defvar *group-icons*
;;   '(("main"  . "󰋑")
;;     ("chat"  . "󰭹")
;;     ("media"  . "")
;;     ("zoom"  . "")))

;; (defun fmt-groups (ml)
;;   (declare (ignore ml))
;;   (let ((current (stumpwm:current-group)))
;;     (format nil "~{~a~^ ~}";s
;;       (mapcar (lambda (g)
;;                 (let* ((name (stumpwm:group-name g))
;;                        (icon (or (cdr (assoc name *group-icons* :test #'string=))
;;                                  name))  ; fall back to name if no icon defined
;;                        (label (format nil "~a" icon)))
;;                   (if (eq g current)
;;                     (format nil "^R~a^r" label)   ; highlight current group
;;                     label)))
;;               (stumpwm:screen-groups (stumpwm:current-screen))))))

;; (stumpwm:add-screen-mode-line-formatter #\G 'fmt-groups)

(setf *mouse-focus-policy* :click)
(setf *window-format* "%m%n%s%4c|%4t")
;; (setf *window-format* "%m%n%s%c")

;; (setf *screen-mode-line-format* (list "[^B%n^b] %W^>%d"))
(setf *time-modeline-string* "%b %e %k:%M")
(setf *window-border-style* :thin)

(run-shell-command "picom --backend xrender -b")
(run-shell-command "dunst")
(run-shell-command "xrdb -merge ~/.Xresources")
;; (run-shell-command "bash -c ~/.screenlayout/default.sh")

(set-module-dir "~/.stumpwm.d/modules/")

;; (load-module "battery-portable")

;; (defun fmt-lang (ml)
;;   (declare (ignore ml))
;;   (string-trim '(#\Newline #\Space)
;;                (stumpwm:run-shell-command "xkb-switch -p" t)))

;; (stumpwm:add-screen-mode-line-formatter #\L 'fmt-lang)

;; (setf stumpwm:*mode-line-timeout* 1)


;; ---- power
(ql:quickload :str)

(defparameter *power-icons*
  (pairlis (list "balanced" "power-saver" "performance")
           (list "󰚀" "󰌪" "")))

(defstruct power-mode name selectedp)

(defun power-modes ()
  (mapcar
   (lambda (x)
     (let ((v1 (str:trim x :char-bag (cons #\: str:*whitespaces*))))
       (if (str:starts-with? "*" v1)
           (make-power-mode :name (subseq v1 2)
                            :selectedp t)
           (make-power-mode :name v1
                            :selectedp nil))))
   (remove-if-not
    (lambda (x) (str:ends-with? ":" x))
    (str:lines
     (with-output-to-string (s)
       (uiop:run-program "powerprofilesctl" :output s)
       s)))))

(defparameter *selected-power-mode* "~")

(defun selected-power-mode ()
  (let ((p (find-if #'power-mode-selectedp (power-modes))))
    (if p (power-mode-name p) "~")))

(setf *selected-power-mode* (selected-power-mode))

(defcommand select-power-mode () () "select-power-mode"
  (let* ((candidates (power-modes))
         (vals (mapcar (lambda (c)
                         (let ((icon (cdr (assoc (power-mode-name c)
                                                 *power-icons*
                                                 :test #'string=))))
                           (cons (format nil
                                         (if (power-mode-selectedp c)
                                             " ~a ~a  "
                                             "  ~a ~a  ")
                                         icon
                                         (power-mode-name c))
                                 (power-mode-name c))))
                       candidates))
         (selection (select-from-menu
                     (current-screen)
                     vals
                     "  󱐋 Power mode:"
                     (position-if #'power-mode-selectedp candidates))))
    (when selection
      (run-shell-command (format nil "powerprofilesctl set ~a" (cdr selection)))
      (setf *selected-power-mode* (cdr selection))
      (format nil "Selected power mode: ~a" (cdr selection)))))

(define-key *root-map* (kbd "~") "select-power-mode")

(defun fmt-power (&rest args)
  (declare (ignore args))
  (let ((icon (cdr (assoc *selected-power-mode*
                          *power-icons*
                          :test #'string=))))
    (or icon "~")))

(add-screen-mode-line-formatter #\Z 'fmt-power)
;; ----

(setf *froup-format* "%n%s%t")

(setf *screen-mode-line-format*
      (list "[%n]"                      ; Groups
            "%v"                        ; Windows
            "^>"                        ; Push right
            ;; "[%P|%M]"                ; pamixer
            ;; " | %B"                     ; battery
            " %d"                       ; clock
            " %Z"
            "%T"                        ; tray
            ))

(enable-mode-line (current-screen) (current-head) t)

(stumpwm:add-to-load-path "~/.stumpwm.d/modules/pamixer")
(load-module "pamixer")

;; (add-screen-mode-line-formatter #\M 'pamixer:source-modeline)
;; (setf pamixer:*modeline-fmt* "%v")
;; (setf pamixer:*source-modeline-fmt* "%v")

(define-key *top-map* (kbd "XF86AudioRaiseVolume") "pamixer-volume-up")
(define-key *top-map* (kbd "XF86AudioLowerVolume") "pamixer-volume-down")
(define-key *top-map* (kbd "XF86AudioMute") "pamixer-toggle-mute")
(define-key *top-map* (kbd "XF86AudioMicMute") "pamixer-source-toggle-mute")

;; (ql:quickload :py-configparser)
;; (load-module "desktop-entry")

(load-module "stump-backlight")
(setf stump-backlight::*use-clx-randr* nil)
(define-key *root-map* (kbd "XF86MonBrightnessUp") "backlight-increase")
(define-key *root-map* (kbd "XF86MonBrightnessDown") "backlight-decrease")


(load-module "winner-mode")
(defvar *winner-map* (make-sparse-keymap))

(define-key *root-map* (kbd "c") '*winner-map*)

(define-key *winner-map* (kbd "Left") "winner-undo")
(define-key *winner-map* (kbd "Right") "winner-redo")

(add-hook *post-command-hook* (lambda (command)
                                (when (member command winner-mode:*default-commands*)
                                  (winner-mode:dump-group-to-file))))

(defun lock-screen ()
  (run-shell-command "slock"))

(defcommand slock () () "lock screen" (lock-screen))

(define-key *top-map* (kbd "s-l") "slock")

;; Core palette (from modus-themes-vivendi-palette)
;; bg-main #000000, fg-main #ffffff, fg-dim #989898,
;; bg-dim #1e1e1e, bg-active #535353, bg-inactive #303030,
;; border #646464, blue-warmer #79a8ff, magenta-cooler #b6a0ff,
;; fg-added (green) #a0e0a0, warning (yellow) #fec43f, variable (cyan) #00d3d0

(set-fg-color "#ffffff")
(set-bg-color "#000000")
(set-border-color "#646464")
(set-win-bg-color "#000000")
(set-focus-color "#79a8ff")     ; focused window border, modus-vivendi's signature blue
(set-unfocus-color "#303030")   ; unfocused border, subtle

(setf *colors*
      '("#000000"   ; 0 black
        "#ff5f59"   ; 1 red    (approximation - couldn't verify exact upstream value)
        "#a0e0a0"   ; 2 green
        "#fec43f"   ; 3 yellow
        "#79a8ff"   ; 4 blue
        "#b6a0ff"   ; 5 magenta
        "#00d3d0"   ; 6 cyan
        "#ffffff")) ; 7 white

(update-color-map (current-screen))

(setf *mode-line-background-color* "#1e1e1e")
(setf *mode-line-foreground-color* "#ffffff")
(setf *mode-line-border-color* "#646464")
(setf *mode-line-highlight-template* "^B^3~A^n")
(setf *message-window-gravity* :bottom)  ; messages + all interactive menus/lists
(setf *input-window-gravity* :bottom)    ; the colon-command input bar
(setf *message-window-padding* 10)


;; Message/input bar
;; (set-font "-*-terminus-medium-r-normal-*-32-*-*-*-*-*-*-*")
;; (set-msg-border-width 2)
;; (setf *message-window-padding* 24)
;; (setf *message-window-y-padding* 14)

;; ;; Mode line
;; (setf *mode-line-border-width* 2)
;; (setf *mode-line-pad-x* 10)
;; (setf *mode-line-pad-y* 6)

;; ;; Window borders (tiled windows, transient/popups, maxsize windows)
;; (setf *normal-border-width* 3)
;; (setf *transient-border-width* 3)
;; (setf *maxsize-border-width* 3)

;; Frame indicator (the number overlay shown when splitting/selecting frames)
(set-frame-outline-width 4)

;; (sync-all-frame-windows (current-group))

;; (ql:quickload :clx-true type)
;; (load-module "ttf-fonts")
;; (set-font (make-instance 'xft:font :family "DejaVu Sans Mono" :size 20))

(load-module "end-session")

(define-key *top-map* (kbd "s-ESC") "end-session")

(push #p"/home/leet/.stumpwm.d/modules/clx-truetype/" asdf:*central-registry*)
(ql:quickload :clx-truetype)
(load-module "ttf-fonts")
;; (set-font (make-instance 'xft:font :family "FiraCode Nerd Font Mono" :subfamily "Regular" :size 36))

(in-package :xft)

(setf +font-cache-filename+
      (merge-pathnames "font-cache.sexp" (merge-pathnames ".fonts/" (user-homedir-pathname))))
(setf *font-dirs*
      (remove-duplicates
       (append *font-dirs*
               (list (namestring (merge-pathnames ".nix-profile/share/fonts/" (user-homedir-pathname)))))))

(in-package :stumpwm-user)

(xft:cache-fonts)
(set-font (make-instance 'xft:font :family "FiraCode Nerd Font Mono" :subfamily "Regular" :size 20))

(toggle-mode-line (current-screen) (current-head))
(toggle-mode-line (current-screen) (current-head))

(ql:quickload :xembed)
(load-module "stumptray")
(setf stumptray:*tray-placeholder-pixels-per-space* 15)
(stumptray:stumptray)

(run-shell-command "nm-applet")
(run-shell-command "gxkb")
(run-shell-command "cbatticon")
(run-shell-command "pasystray")
(run-shell-command "sleep 1 && blueman-applet")

;; (define-key *root-map* (kbd "C-c") "ghostty")
;; (defun ensure-english-layout (key key-seq cmd)
;;   (declare (ignorable key cmd))
;;   (when (= (length key-seq) 1)
;;     (message (format nil "~a" key))
;;     (sb-ext:run-program "/usr/bin/xkb-switch" '("-s" "us") :wait nil)))

;; (add-hook *key-press-hook* 'ensure-english-layout)

(load-module "swm-gaps")

;; Head gaps run along the 4 borders of the monitor(s)
(setf swm-gaps:*head-gaps-size* 0)

;; Inner gaps run along all the 4 borders of a window
(setf swm-gaps:*inner-gaps-size* 20)

;; Outer gaps add more padding to the outermost borders of a window (touching
;; the screen border)
(setf swm-gaps:*outer-gaps-size* 20)

(define-key *root-map* (kbd "/") "toggle-gaps")

(defcommand show-bg () () "show bg"
  (run-shell-command "feh --bg-fill ~/wallpapers/bg.jpg"))

(ql:quickload :frugal-uuid)

;; (defcommand rand-bg () () "reload background"
;;   (let ((cmd (format
;;               nil
;;               "curl -Lo ~~/wallpapers/bg.jpg 'https://picsum.photos/seed/~a/2560/1440'"
;;               (frugal-uuid:to-string (frugal-uuid:make-v4)))))
;;     (run-shell-command cmd t)
;;     (show-bg)))

(defcommand rand-bg () () "reload background"
  (let* ((fname (format nil "~~/wallpapers/bg_~a.jpg"
                        (frugal-uuid:to-string (frugal-uuid:make-v4))))
         (cmd (format
               nil
               "curl -o ~a $(curl -s 'https://api.unsplash.com/photos/random?client_id=0K52ovtIlWFmKWQJbG37-iBVqK9OWy62vUFRgqH03Ww&count=1&w=2560&h=1440&min-w=2560&fit=crop&orientation=landscape' | jq -r '.[0].urls.raw')"
               fname)))
    (run-shell-command cmd t)
    (run-shell-command (format nil "cp ~a ~~/wallpapers/bg.jpg" fname) t)
    (show-bg)))

(show-bg)

(load-module "swm-golden-ratio")
(define-key *root-map* (kbd "C-%") "toggle-golden-ratio")

(load-module "globalwindows")
(define-key *root-map* (kbd ".") "global-windowlist")
(define-key *root-map* (kbd ",") "global-pull-windowlist")

;; (define-key *top-map* (kbd "s-TAB") "pull-hidden-next")

(defcommand run-or-raise-ghostty () ()
  (run-or-raise "ghostty" '(:class "ghostty")))

(define-key *root-map* (kbd "C-c") "run-or-raise-ghostty")

(defcommand run-or-raise-vivaldi-stable () ()
  (run-or-raise "vivaldi" '(:class "Vivaldi-stable")))

(define-key *root-map* (kbd "C-r") "run-or-raise-vivaldi-stable")

(defcommand run-or-raise-slack () ()
  (run-or-raise "slack" '(:class "Slack")))

(define-key *root-map* (kbd "C-s") "run-or-raise-slack")


(defun zoom-window-to-group (window)
  (when (string= (stumpwm:window-class window) "zoom")
    (let ((zoom-group (stumpwm::find-group (stumpwm:current-screen) "zoom")))
      (when zoom-group
        (stumpwm:move-window-to-group window zoom-group)))))

(add-hook stumpwm:*new-window-hook* 'zoom-window-to-group)

;; (stumpwm:float-this)g
;; (stumpwm:unfloat-this)
;; (stumpwm:flatten-floats)

(defvar *float-map* (make-sparse-keymap))

(define-key *root-map* (kbd "=") '*float-map*)

(define-key *float-map* (kbd "=") "unfloat-this")
(define-key *float-map* (kbd "-") "float-this")
(define-key *float-map* (kbd "!") "toggle-always-on-top")
(define-key *float-map* (kbd "@") "toggle-always-show")

;; (define-key *top-map* (kbd "s-[") "gprev")
;; (define-key *top-map* (kbd "s-]") "gnext")

;; (define-key *top-map* (kbd "s-{") "gprev-with-window")
;; (define-key *top-map* (kbd "s-}") "gnext-with-window")

;; (define-key *top-map* (kbd "s-TAB") "pull-hidden-next")
;; (define-key *top-map* (kbd "s-ISO_Left_Tab") "pull-hidden-previous")

;; (define-key *top-map* (kbd "s-RET") "expose")
;; (define-key *top-map* (kbd "s-o") "fnext")
;; (define-key *top-map* (kbd "s-O") "fother")

;; (define-key *top-map* (kbd "s-f") "fselect")
;; (define-key *top-map* (kbd "s-s") "vsplit")
;; (define-key *top-map* (kbd "s-S") "hsplit")
;; (define-key *top-map* (kbd "s-O") "fother")
;; (define-key *top-map* (kbd "s-O") "fother")


(run-shell-command "flameshot")
(defcommand flameshot () () "screenshot" (run-shell-command "flameshot gui"))
(define-key *top-map* (kbd "Print") "flameshot")

(defcommand screen-rec () () "screen-rec" (run-shell-command "simplescreenrecorder"))
(define-key *top-map* (kbd "Sys_Req") "screen-rec")

(defcommand arandr () () "arandr"
            (run-or-raise "arandr" '(:class "Arandr")))

(define-key *top-map* (kbd "XF86Display") "arandr")

(load-module "command-history")

;; todo: check it
;; (setf command-history::*history-file*
;;       (merge-pathnames ".stumpwm.history" (user-homedir-pathname)))

(defun resize-frame (frame new-w new-h)
  (declare (type (or number null) new-w new-h))
  (resize (if new-w (- new-w (frame-width frame)) 0)
          (if new-h (- new-h (frame-height frame)) 0)))

(defcommand set-frame-width (width) ((:number "Frame width: "))
  (let* ((screen (current-screen))
         (group (current-group))
         (frame (stumpwm::tile-group-current-frame group)))
    (resize-frame frame width nil)))

(defcommand set-frame-height (height) ((:number "Frame height: "))
  (let* ((screen (current-screen))
         (group (current-group))
         (frame (stumpwm::tile-group-current-frame group)))
    (resize-frame frame nil height)))

(defcommand set-frame-size (width height) ((:number "Frame width: ")
                                           (:number "Frame height: "))
  (let* ((screen (current-screen))
         (group (current-group))
         (frame (stumpwm::tile-group-current-frame group)))
    (resize-frame frame width height)))

(setf *resize-increment* 100)
;; (defun get-int-or-float (s)
;;   (let ((n (read-from-string s nil 1.0)))
;;     ))

;; (defcommand aaa (x) ((:string "asd: "))
;;             ()
;;             (message x))

(run-shell-command "albert")

(defcommand what-window () ()
  (message "class: ~a instance: ~a"
           (window-class (current-window))
           (window-res (current-window))))

(defun move-albert-to-current-group (window)
  (when (string= (window-class window) "albert")
    (move-window-to-group window (current-group))))

(defcommand toggle-transparency () ()
  (run-shell-command "transset --actual --toggle 0.85"))

(define-key *root-map* (kbd "C-/") "toggle-transparency")

(defcommand hide-all-but-current () ()
  (when-let (cur (current-window))
    (let ((to-hide (remove cur (group-windows (current-group)))))
      (dolist (w to-hide)
        (stumpwm::hide-window w)))))

(define-key *root-map* (kbd "M-/") "hide-all-but-current")

(add-hook *new-window-hook* #'move-albert-to-current-group)

(defcommand toggle-modeline-transparency () ()
  (loop for l in stumpwm::*mode-lines*
        for w = (xlib:window-id (stumpwm::mode-line-window l))
        do (run-shell-command (format nil "transset --id ~a --toggle 0.85" w))))
