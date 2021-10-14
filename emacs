(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
;;(add-to-list 'load-path user-emacs-directory)

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
	   (add-hook 'sh-mode-hook 'wfp5p-no-color-mode-hook))
)

;; turn on ido just for buffer ops
(unless noninteractive
	(ido-mode 'buffer))

(autoload 'describe-unbound-keys "unbound" "show unbound keys" t)

(autoload 'hide-lines "hide-lines" "Hide lines based on a regexp" t)

(defalias 'yes-or-no-p 'y-or-n-p)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(gnus-novice-user nil)
 '(inhibit-startup-screen t)
 '(initial-frame-alist
   '((height . 50)
     (width . 80)
     (height . 50)
     (top + 50)
     (tool-bar-lines)))
 '(initial-scratch-message nil)
 '(isearch-lazy-highlight nil)
 '(make-backup-files nil)
 '(mouse-yank-at-point t)
 '(python-indent-guess-indent-offset nil)
 '(remote-shell-program "ssh")
 '(require-final-newline 'query)
 '(search-highlight t)
 '(shadow-info-file "~/.emacs.d/shadows")
 '(shadow-todo-file "~/.emacs.d/shadow_todo")
 '(show-trailing-whitespace t)
 '(small-temporary-file-directory "/dev/shm")
 '(tool-bar-mode nil nil (tool-bar))
 '(tramp-default-method "ssh")
 '(tramp-syntax 'simplified nil (tramp))
 '(tramp-verbose 8)
 '(truncate-lines t)
 '(uniquify-buffer-name-style 'post-forward nil (uniquify)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Input Mono" :foundry "FBI " :slant normal :weight normal :height 98 :width normal))))
 '(cperl-array-face ((default nil) (nil nil)))
 '(cperl-hash-face ((((class color) (background light)) nil)))
 '(cperl-nonoverridable-face ((t (:foreground "blue"))))
 '(font-lock-builtin-face ((((class color) (min-colors 88) (background light)) (:foreground "magenta"))))
 '(font-lock-comment-face ((((class color) (min-colors 88) (background light)) (:foreground "red2"))))
 '(font-lock-keyword-face ((((class color) (min-colors 8)) (:foreground "blue" :weight normal))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background light)) nil)))
 '(font-lock-type-face ((((class color) (min-colors 88) (background light)) (:foreground "khaki4"))))
 '(font-lock-variable-name-face ((((class color) (min-colors 88) (background light)) (:foreground "NavyBlue"))))
 '(region ((t (:background "gray85" :foreground "black")))))

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

;;  is this still needed?
(eval-after-load "tramp-sh"
   '(defun tramp-open-shell (vec shell)
  "Opens shell SHELL."
  (with-tramp-progress-reporter
      vec 5 (format "Opening remote shell `%s'" shell)
    ;; Find arguments for this shell.
    (let ((alist tramp-sh-extra-args)
	  item extra-args)
      (while (and alist (null extra-args))
	(setq item (pop alist))
	(when (string-match (car item) shell)
	  (setq extra-args (cdr item))))
      (tramp-send-command
       vec (format
	    "exec env ENV='' HISTFILE=/tmp/.trampjunk.$$ HISTSIZE=0 PROMPT_COMMAND='' PS1=%s PS2='' PS3='' %s %s"
	    (tramp-shell-quote-argument tramp-end-of-output)
	    shell (or extra-args ""))
       t))
    (tramp-set-connection-property
     (tramp-get-connection-process vec) "remote-shell" shell))))
