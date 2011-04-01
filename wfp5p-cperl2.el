;;(autoload 'cperl-set-style "cperl-mode" "set cperl style" t)


(defun wfp5p-cperl-mode-hook ()
; overwrite the regular abbrev table for cperl
  (let ((prev-a-c abbrevs-changed))
    (clear-abbrev-table cperl-mode-abbrev-table)
    (define-abbrev-table 'cperl-mode-abbrev-table '(
        ("pshebang"   "#! /usr/bin/perl\n\nuse strict;\n" nil 1)
	))
    (setq abbrevs-changed prev-a-c))
  (abbrev-mode 1)
  (setq-default cperl-invalid-face 'default)
  (setq-default cperl-electric-parens 'null)
  (setq-default cperl-electric-keywords 'null)
  (setq-default cperl-auto-newline t)
  (setq-default cperl-autoindent-on-semi t)
  (setq-default cperl-hairy t)
  (turn-on-ws-trim))

(add-hook 'cperl-mode-hook 'wfp5p-cperl-mode-hook)

(provide 'wfp5p-cperl2)
