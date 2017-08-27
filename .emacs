(load-theme 'tango-dark)

; file formats
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.list\\'" . markdown-mode))

(add-to-list 'auto-mode-alist '("\\.tex$" . latex-mode))
(add-to-list 'auto-mode-alist '("\\.pyx$" . python-mode))

(add-to-list 'auto-mode-alist '("\\.mak\\'" . makefile-mode))
(add-to-list 'auto-mode-alist '("Make.*\\'" . makefile-mode))


; electric indentation
(electric-indent-mode 0)

(put 'downcase-region 'disabled nil)


; line truncation
(global-set-key (kbd "<f6>") 'toggle-truncate-lines)

;; ; scroll down in columns
;; (defun sfp-page-down ()
;;   (interactive)
;;   (setq this-command 'next-line)
;;   (next-line
;;    (- (window-text-height)
;;       next-screen-context-lines)))

;; (defun sfp-page-up ()
;;   (interactive)
;;   (setq this-command 'previous-line)
;;   (previous-line
;;    (- (window-text-height)
;;       next-screen-context-lines)))

;; (global-set-key [next] 'sfp-page-down)
;; (global-set-key [prior] 'sfp-page-up)

; no startup screen
(setq inhibit-startup-message t)


; wind move -- use shift + arrows to change windows
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))


; just spaces
(setq-default indent-tabs-mode nil)
