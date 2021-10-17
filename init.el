(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(setq default-frame-alist initial-frame-alist)

(autoload 'turn-on-ws-trim "ws-trim" "turn on wstrim" t)
(autoload 'turn-off-ws-trim "ws-trim" "turn off wstrim" t)

(require 'wfp5p-cc)
(require 'wfp5p-keys)
(require 'wfp5p-cperl)
(require 'wfp5p-python)
(require 'wfp5p-go)

;; Use cperl mode instead of the default perl mode
(defalias 'perl-mode 'cperl-mode)

(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG" . text-mode))
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; there has to be an easier way!
(defun wfp5p-no-color-mode-hook ()
  (font-lock-mode 0)
  )

(if (not (eq window-system 'x))
    (progn (add-hook 'conf-mode-hook 'wfp5p-no-color-mode-hook)
	   (add-hook 'sh-mode-hook 'wfp5p-no-color-mode-hook)
	   (menu-bar-mode -1))
)

;; turn on ido just for buffer ops
(unless noninteractive
	(ido-mode 'buffer))

(autoload 'describe-unbound-keys "unbound" "show unbound keys" t)

(defalias 'yes-or-no-p 'y-or-n-p)

;; Why?
(put 'downcase-region 'disabled nil)

(defun wfp-count-file-buffers ()
  (let ((x 0))
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
	(when (buffer-file-name buffer)
	  (setq x (1+ x)))))
    x))

(defun wfp-kill-emacs-query-function ()
   (if (>= (wfp-count-file-buffers) 2)
       (yes-or-no-p "multiple file buffers; exit anyway? ")
     (not nil)))

(add-hook 'kill-emacs-query-functions 'wfp-kill-emacs-query-function)

(setq rpm-spec-user-mail-address "wfp5p@worldbroken.com")
