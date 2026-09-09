(setq package-enable-at-startup nil)

;; Avoid first-frame flicker by setting frame chrome before it is drawn.
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)
(setq frame-inhibit-implied-resize t)

;; Do not repaint intermediate startup states (prevents visible flash).
(setq inhibit-redisplay t)
(add-hook 'window-setup-hook
          (lambda ()
            (setq inhibit-redisplay nil)
            (redisplay)))

;; Startup acceleration: relax GC and skip expensive file handlers during init.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(defvar gz/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Better throughput for long lines during early startup.
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t
      long-line-threshold 1000
      inhibit-compacting-font-caches t)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 64 1024 1024)
                  gc-cons-percentage 0.1
                  file-name-handler-alist gz/file-name-handler-alist)
            (garbage-collect)))
