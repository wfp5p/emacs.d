(autoload 'cperl-set-style "cperl-mode" "set cperl style" t)

(defun wfp5p-cperl-mode-hook ()
  (setq-default cperl-invalid-face 'default)
  (setq-default cperl-electric-parens nil)
  (setq-default cperl-electric-parens-string nil)
  (setq-default cperl-electric-keywords t)
  (setq-default cperl-auto-newline t)
  (setq-default cperl-autoindent-on-semi t)
  (setq-default cperl-electric-linefeed t)
  (setq-default cperl-hairy t)
  (turn-on-ws-trim)
  (cperl-set-style "BSD"))



(add-hook 'cperl-mode-hook 'wfp5p-cperl-mode-hook)


(provide 'wfp5p-cperl)
