(setq wfp5p-modes-alist '( ("/lv2/work/kernel" . "linux")))

(defconst wfp5p-c-style
  '("bsd"
    (c-basic-offset . 4)))

(c-add-style "wfp5p" wfp5p-c-style)

(defun wfp5p-c-mode-hook ()
  (setq-default c-electric-flag t)
  (setq-default c-auto-newline t)
  (define-key c-mode-map "{" 'self-insert-command)
;;  (define-key c-mode-map "}" 'self-insert-command)
  (turn-on-ws-trim)
  (let ((default-mode "linux")
	(mode)
	(name))
    (setq name (file-truename buffer-file-name))
    (setq mode (assoc-default name wfp5p-modes-alist 'string-match))
    (if (stringp mode)
	(c-set-style mode)
      (c-set-style default-mode))))


(add-hook 'c-mode-common-hook 'wfp5p-c-mode-hook)


(provide 'wfp5p-cc)
