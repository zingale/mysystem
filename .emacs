
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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

; castro inputs files
(add-to-list 'auto-mode-alist '("inputs*" . conf-mode))

; electric indentation
(electric-indent-mode 0)

(put 'downcase-region 'disabled nil)


; whitespace
(add-hook 'python-mode-hook (setq-default show-trailing-whitespace t))


; spelling
; see https://joelkuiper.eu/spellcheck_emacs
(dolist (hook '(latex-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

(dolist (hook '(rst-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))


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


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (csv-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

