
(setq fn '("/lv2/users/wfp5p/kernel/linux-2.6"))

(defconst wfp5p-c-style
  '("bsd"
    (c-basic-offset . 4)))

(c-add-style "wfp5p" wfp5p-c-style)

(defun wfp5p-c-mode-hook ()
  (c-set-style "wfp5p")
  (turn-on-ws-trim)
  (setq buffer-file-truename (file-truename buffer-file-name))
    (when (string-match (regexp-opt fn) buffer-file-truename)
	(c-set-style "linux")))


(add-hook 'c-mode-common-hook 'wfp5p-c-mode-hook)


(provide 'wfp5p-cc)
