(defun bind-auto-mode (pattern mode)
  (setq auto-mode-alist
	(cons (cons pattern mode)
	      auto-mode-alist)))

(bind-auto-mode "\\.h$" 'c++-mode)
(add-hook 'c++-mode-hook 'linum-mode)
(add-hook 'java-mode-hook 'linum-mode)
(add-hook 'c++-mode-hook 'subword-mode)
(set-face-foreground 'minibuffer-prompt "green")
(set-face-foreground 'font-lock-comment-face "magenta")
(global-set-key [?\C-x ?\g] 'goto-line)
(setq-default c-basic-offset 2)
(global-set-key [?\C-x ?'] 'compare-windows)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 8)

(global-set-key [?\C-z] 'undo)
(global-set-key [?\C-x ?/] 'comment-region)


(setq shell-file-name (or (getenv "SHELL") "/usr/bin/bash"))

(add-to-list 'load-path "~/elisp/git")
(add-to-list 'load-path "~/elisp")
(add-to-list 'load-path "~/elisp/smart-mode-line-master")
(add-to-list 'load-path "~/elisp/exec-path-from-shell-master")
(require 'git)
(require 'git-blame)

(require 'exec-path-from-shell)
(when (memq window-system '(x w32))
  (exec-path-from-shell-initialize))


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
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(auto-insert (quote not-modified))
 '(auto-insert-alist
   (quote
    ((("\\.\\([Hh]\\|hh\\|hpp\\|hxx\\|h\\+\\+\\)\\'" . "C / C++ header")
      (concat
       (replace-regexp-in-string "[^A-Z0-9]" "_"
                                 (replace-regexp-in-string "\\+" "P"
                                                           (upcase
                                                            (file-name-nondirectory buffer-file-name))))
       (format "_%08X"
               (random
                (1-
                 (expt 16 8)))))
      "#ifndef " str n "#define " str "

" _ "

#endif // " str)
     (("\\.\\([Cc]\\|cc\\|cpp\\|cxx\\|c\\+\\+\\)\\'" . "C / C++ program")
      nil "#include \""
      (let
          ((stem
            (file-name-sans-extension buffer-file-name))
           ret)
        (dolist
            (ext
             (quote
              ("H" "h" "hh" "hpp" "hxx" "h++"))
             ret)
          (when
              (file-exists-p
               (concat stem "." ext))
            (setq ret
                  (file-name-nondirectory
                   (concat stem "." ext))))))
      & 34 | -10)
     (("[Mm]akefile\\'" . "Makefile")
      . "makefile.inc")
     (html-mode lambda nil
                (sgml-tag "html"))
     (plain-tex-mode . "tex-insert.tex")
     (bibtex-mode . "tex-insert.tex")
     (latex-mode "options, RET: " "\\documentclass[" str & 93 | -1 123
                 (read-string "class: ")
                 "}
"
                 ("package, %s: " "\\usepackage["
                  (read-string "options, RET: ")
                  & 93 | -1 123 str "}
")
                 _ "
\\begin{document}
" _ "
\\end{document}")
     (("/bin/.*[^/]\\'" . "Shell-Script mode magic number")
      lambda nil
      (if
          (eq major-mode
              (default-value
                (quote major-mode)))
          (sh-mode)))
     (ada-mode . ada-header)
     (("\\.[1-9]\\'" . "Man page skeleton")
      "Short description: " ".\\\" Copyright (C), "
      (format-time-string "%Y")
      "  "
      (getenv "ORGANIZATION")
      |
      (progn user-full-name)
      "
.\\\" You may distribute this file under the terms of the GNU Free
.\\\" Documentation License.
.TH "
      (file-name-base)
      " "
      (file-name-extension
       (buffer-file-name))
      " "
      (format-time-string "%Y-%m-%d ")
      "
.SH NAME
"
      (file-name-base)
      " \\- " str "
.SH SYNOPSIS
.B "
      (file-name-base)
      "
" _ "
.SH DESCRIPTION
.SH OPTIONS
.SH FILES
.SH \"SEE ALSO\"
.SH BUGS
.SH AUTHOR
"
      (user-full-name)
      (quote
       (if
           (search-backward "&"
                            (line-beginning-position)
                            t)
           (replace-match
            (capitalize
             (user-login-name))
            t t)))
      (quote
       (end-of-line 1))
      " <"
      (progn user-mail-address)
      ">
")
     (("\\.el\\'" . "Emacs Lisp header")
      "Short description: " ";;; "
      (file-name-nondirectory
       (buffer-file-name))
      " --- " str
      (make-string
       (max 2
            (- 80
               (current-column)
               27))
       32)
      "-*- lexical-binding: t; -*-"
      (quote
       (setq lexical-binding t))
      "

;; Copyright (C) "
      (format-time-string "%Y")
      "  "
      (getenv "ORGANIZATION")
      |
      (progn user-full-name)
      "

;; Author: "
      (user-full-name)
      (quote
       (if
           (search-backward "&"
                            (line-beginning-position)
                            t)
           (replace-match
            (capitalize
             (user-login-name))
            t t)))
      (quote
       (end-of-line 1))
      " <"
      (progn user-mail-address)
      ">
;; Keywords: "
      (quote
       (require
        (quote finder)))
      (quote
       (setq v1
             (mapcar
              (lambda
                (x)
                (list
                 (symbol-name
                  (car x))))
              finder-known-keywords)
             v2
             (mapconcat
              (lambda
                (x)
                (format "%12s:  %s"
                        (car x)
                        (cdr x)))
              finder-known-keywords "
")))
      ((let
           ((minibuffer-help-form v2))
         (completing-read "Keyword, C-h: " v1 nil t))
       str ", ")
      & -2 "

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; " _ "

;;; Code:



(provide '"
      (file-name-base)
      ")
;;; "
      (file-name-nondirectory
       (buffer-file-name))
      " ends here
")
     (("\\.texi\\(nfo\\)?\\'" . "Texinfo file skeleton")
      "Title: " "\\input texinfo   @c -*-texinfo-*-
@c %**start of header
@setfilename "
      (file-name-base)
      ".info
" "@settitle " str "
@c %**end of header
@copying
"
      (setq short-description
            (read-string "Short description: "))
      ".

" "Copyright @copyright{} "
      (format-time-string "%Y")
      "  "
      (getenv "ORGANIZATION")
      |
      (progn user-full-name)
      "

@quotation
Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
A copy of the license is included in the section entitled ``GNU
Free Documentation License''.

A copy of the license is also available from the Free Software
Foundation Web site at @url{http://www.gnu.org/licenses/fdl.html}.

@end quotation

The document was typeset with
@uref{http://www.texinfo.org/, GNU Texinfo}.

@end copying

@titlepage
@title " str "
@subtitle " short-description "
@author "
      (getenv "ORGANIZATION")
      |
      (progn user-full-name)
      " <"
      (progn user-mail-address)
      ">
@page
@vskip 0pt plus 1filll
@insertcopying
@end titlepage

@c Output the table of the contents at the beginning.
@contents

@ifnottex
@node Top
@top " str "

@insertcopying
@end ifnottex

@c Generate the nodes for this menu with `C-c C-u C-m'.
@menu
@end menu

@c Update all node entries with `C-c C-u C-n'.
@c Insert new nodes with `C-c C-c n'.
@node Chapter One
@chapter Chapter One

" _ "

@node Copying This Manual
@appendix Copying This Manual

@menu
* GNU Free Documentation License::  License for copying this manual.
@end menu

@c Get fdl.texi from http://www.gnu.org/licenses/fdl.html
@include fdl.texi

@node Index
@unnumbered Index

@printindex cp

@bye

@c "
      (file-name-nondirectory
       (buffer-file-name))
      " ends here
"))))
 '(auto-insert-mode t)
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tango-dark)))
'(custom-safe-themes
(quote
 ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(printer-name "FinePrint")
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Lucida Console" :foundry "outline" :slant normal :weight normal :height 113 :width normal)))))
