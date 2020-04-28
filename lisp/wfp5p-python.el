(defun wfp5p-python-mode-hook ()
  (define-abbrev-table 'python-mode-abbrev-table
    '(("pshebang" "#! /bin/python"))
    )
  (abbrev-mode 1)
  (setq-default python-indent-offset 4)
  )

(add-hook 'python-mode-hook 'wfp5p-python-mode-hook)

(provide 'wfp5p-python)
