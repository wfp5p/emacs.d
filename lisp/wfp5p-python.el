(defun wfp5p-python-mode-hook ()
  (define-abbrev-table 'python-mode-abbrev-table
    '(("pshebang" "#! /bin/python3"))
    )
  (abbrev-mode 1)
  )

(add-hook 'python-mode-hook 'wfp5p-python-mode-hook)

(provide 'wfp5p-python)
