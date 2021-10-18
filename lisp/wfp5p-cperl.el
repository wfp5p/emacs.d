(autoload 'cperl-set-style "cperl-mode" "set cperl style" t)

(defadvice cperl-electric-paren (after do-indent preactivate)

  "Run cperl-indent-line after a paren"
  (cperl-indent-line))

(ad-activate 'cperl-electric-paren)

;; cperl-hariy will set these:
;; cperl-font-lock
;; cperl-electric-lbrace-space
;; cperl-electric-parens
;; cperl-electric-linefeed
;; cperl-electric-keywords
;; cperl-info-on-command-no-prompt
;; cperl-clobber-lisp-bindings
;; cperl-lazy-help-time

(defun wfp5p-cperl-mode-hook ()
; overwrite the regular abbrev table for cperl
  (let ((prev-a-c abbrevs-changed))
    (clear-abbrev-table cperl-mode-abbrev-table)
    (define-abbrev-table 'cperl-mode-abbrev-table '(
        ("pshebang"   "#! /usr/bin/perl\n\nuse strict;\nuse feature ':5.10';" nil 1)
	))
    (setq abbrevs-changed prev-a-c))
  (abbrev-mode 1)
  (setq-default cperl-invalid-face 'default)
  (setq-default cperl-electric-parens 'null)
  (setq-default cperl-electric-keywords 'null)
;  (setq-default cperl-auto-newline t)
  (setq-default cperl-autoindent-on-semi t)
  (setq-default cperl-hairy t)
;  (cperl-define-key "\C-c\C-c" 'comment-region)
  (cperl-set-style "BSD"))

(add-hook 'cperl-mode-hook 'wfp5p-cperl-mode-hook)


(provide 'wfp5p-cperl)
