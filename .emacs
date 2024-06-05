;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(load-theme 'tango-dark)

; file formats
(load "~/mysystem/markdown-mode.el")
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.list\\'" . markdown-mode))

(add-to-list 'auto-mode-alist '("\\.tex$" . latex-mode))
(add-to-list 'auto-mode-alist '("\\.pyx$" . python-mode))

(add-to-list 'auto-mode-alist '("\\.mak\\'" . makefile-mode))
(add-to-list 'auto-mode-alist '("^Make.*\\'" . makefile-mode))

; castro inputs files
(add-to-list 'auto-mode-alist '("inputs*" . conf-mode))

; electric indentation
(electric-indent-mode 0)

(put 'downcase-region 'disabled nil)


; whitespace
(add-hook 'python-mode-hook (setq-default show-trailing-whitespace t))

; C++ 4 spaces indenting
(setq-default c-default-style "linux"
              c-basic-offset 4)

; spelling
; see https://joelkuiper.eu/spellcheck_emacs
(dolist (hook '(latex-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

(dolist (hook '(rst-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

(dolist (hook '(html-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

(dolist (hook '(markdown-mode-hook))
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

; C++ seems to override the default tabs.  See
; https://emacs.stackexchange.com/questions/12173/confusion-by-the-usage-of-indent-tabs-mode-nil

(defun endless/c-hook ()
  (setq indent-tabs-mode nil))
(add-hook 'c++-mode-hook #'endless/c-hook)

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

; show the function name on the status bar
(which-function-mode 1)


(show-paren-mode 1)

; use C-c p to jump between matching parens
; see https://stackoverflow.com/questions/9454489/emacs-brace-and-bracket-highlighting

(defun goto-matching-paren ()
  "If point is sitting on a parenthetic character, jump to its match."
  (interactive)
  (cond ((looking-at "\\s\(") (forward-list 1))
        ((progn
           (backward-char 1)
           (looking-at "\\s\)")) (forward-char 1) (backward-list 1))))
(define-key global-map [(control ?c) ?p] 'goto-matching-paren) ; Bind to C-c p

;; rainbow paranthesis
(load "~/mysystem/rainbow-delimiters.el")
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'latex-mode-hook 'rainbow-delimiters-mode)
(add-hook 'markdown-mode-hook 'rainbow-delimiters-mode)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.

 '(rainbow-delimiters-depth-1-face ((t (:foreground "brightyellow"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "brightred"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "brightgreen"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "brightcyan"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "brightyellow"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "brightred"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "brightgreen"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "brightcyan"))))
 '(rainbow-delimiters-unmatched-face ((t (:background "cyan"))))

 )

;; https://yoo2080.wordpress.com/2013/09/08/living-with-rainbow-delimiters-mode/
;; make unmatched stand out
;;(set-face-attribute 'rainbow-delimiters-unmatched-face nil
;;                    :foreground 'unspecified
;;                    :inherit 'error
;;                    :strike-through t)


(set-face-italic 'font-lock-comment-face 1)


;; highlight the current line
;; https://emacs.stackexchange.com/questions/27821/highlight-current-line-without-changing-colours
(global-hl-line-mode 1)
(set-face-background 'hl-line "#333334")
(set-face-foreground 'highlight nil)

;; 24.1 changed how backspace worked
(setq delete-active-region nil)

;; show line numbers

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; column number mode
(setq column-number-mode t)


;; window tab line
(global-tab-line-mode 1)


;; python
(add-hook 'python-mode-hook 'flycheck-mode)


;; C+
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++17")))

(put 'upcase-region 'disabled nil)

;; editorconfig
(add-to-list 'load-path "~/mysystem/editorconfig-20230919.2101/")
(require 'editorconfig)
(editorconfig-mode 1)

;; company-mode (autocomplete)
;;(add-hook 'after-init-hook 'global-company-mode)

