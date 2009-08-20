(autoload 'cperl-set-style "cperl-mode" "set cperl style" t)

(defun wfp5p-cperl-mode-hook ()
  (setq-default cperl-hairy t)
  (setq-default cperl-electric-parens nil)
  (setq-default cperl-electric-parens-string nil)
  (turn-on-ws-trim)
  (cperl-set-style "BSD"))


(add-hook 'cperl-mode-hook 'wfp5p-cperl-mode-hook)


(provide 'wfp5p-cperl)
