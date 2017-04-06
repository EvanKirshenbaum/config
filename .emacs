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
(require 'git)
(require 'git-blame)

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
  "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
(autoload 'csv-mode "csv-mode"
  "Major mode for editing comma-separated value files." t)
