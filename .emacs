(defun bind-auto-mode (pattern mode)
  (setq auto-mode-alist
	(cons (cons pattern mode)
	      auto-mode-alist)))

(bind-auto-mode "\\.h$" 'c++-mode)
(add-hook 'c++-mode-hook 'linum-mode)
(add-hook 'java-mode-hook 'linum-mode)
(set-face-foreground 'minibuffer-prompt "green")
(set-face-foreground 'font-lock-comment-face "magenta")
(global-set-key [?\C-x ?\g] 'goto-line)
(setq-default c-basic-offset 2)
(global-set-key [?\C-x ?'] 'compare-windows)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 8)

(add-to-list 'load-path "~/elisp/git")
(add-to-list 'load-path "~/elisp")
(add-to-list 'load-path "~/elisp/smart-mode-line-master")
(require 'git)
(require 'git-blame)

(autoload 'sml/setup "smart-mode-line")
(setq sml/no-confirm-load-theme t)
(setq sml/theme 'respectful)
;;(sml/setup)

(set-face-foreground 'mode-line "pink")
(set-face-background 'mode-line "gray10")
(set-face-foreground 'mode-line-inactive "gray")
(set-face-background 'mode-line-inactive "gray40")
(set-face-background 'mode-line-buffer-id "black")
(set-face-foreground 'mode-line-buffer-id "white")

;; (set-face-attribute  'mode-line
;;                  nil 
;;                  :foreground "gray80"
;;                  :background "gray25" 
;;                  :box '(:line-width 1 :style released-button))
;; (set-face-attribute  'mode-line-inactive
;;                  nil 
;;                  :foreground "gray30"
;;                  :background MY_BG_COLOR 
;;                  :box '(:line-width 1 :style released-button))

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
  "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("INSTALL\\.md\\'" . gfm-mode))

(add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
(autoload 'csv-mode "csv-mode"
  "Major mode for editing comma-separated value files." t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
