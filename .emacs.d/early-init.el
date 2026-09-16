;;; -*- lexical-binding: t; -*-

(setq native-comp-async-report-warnings-errors nil)
(menu-bar-mode -99)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(horizontal-scroll-bars) default-frame-alist)
(push '(background-color . "grey9") default-frame-alist)

;; Ask for a maximized/fullscreen frame from the very first frame creation
(push '(fullscreen . maximized) default-frame-alist)

;; Stop Emacs from silently resizing the frame later because of font/toolbar
;; changes computed during startup — this is what causes the second "jump".
(setq frame-inhibit-implied-resize t)

;; Pixelwise resizing avoids rounding to character-cell boundaries, which can
;; also cause a visible snap once the real font is loaded.
(setq frame-resize-pixelwise t)
