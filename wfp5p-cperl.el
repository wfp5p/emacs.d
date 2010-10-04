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
  (setq-default cperl-invalid-face 'default)
  (setq-default cperl-electric-parens 'null)
  (setq-default cperl-electric-keywords 'null)
  (setq-default cperl-auto-newline t)
  (setq-default cperl-autoindent-on-semi t)
  (setq-default cperl-hairy t)
  (turn-on-ws-trim)
  (cperl-set-style "BSD"))

(add-hook 'cperl-mode-hook 'wfp5p-cperl-mode-hook)


(provide 'wfp5p-cperl)
