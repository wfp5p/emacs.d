(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
;;(add-to-list 'load-path user-emacs-directory)

(require 'wfp5p-cc)
(require 'wfp5p-keys)
(require 'wfp5p-cperl)
(require 'yaml-mode)
(require 'go-mode)

(add-hook 'go-mode-hook
	  (lambda ()
	    (setq tab-width 4)))

(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.eml$" . text-mode))

;; turn on ido just for buffer ops
(unless noninteractive
	(ido-mode 'buffer))

(autoload 'turn-on-ws-trim "ws-trim" "turn on wstrim" t)
(autoload 'turn-off-ws-trim "ws-trim" "turn off wstrim" t)

(autoload 'describe-unbound-keys "unbound" "show unbound keys" t)

(autoload 'hide-lines "hide-lines" "Hide lines based on a regexp" t)

(setq puppet-indent-level 4)

(defalias 'yes-or-no-p 'y-or-n-p)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(gnus-novice-user nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(isearch-lazy-highlight nil)
 '(mouse-yank-at-point t)
 '(remote-shell-program "ssh")
 '(search-highlight t)
 '(shadow-info-file "~/.emacs.d/shadows")
 '(shadow-todo-file "~/.emacs.d/shadow_todo")
 '(show-trailing-whitespace t)
 '(small-temporary-file-directory "/dev/shm")
 '(tool-bar-mode nil nil (tool-bar))
 '(tramp-verbose 8)
 '(transient-mark-mode t)
 '(truncate-lines t)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify)))

;; turn off backups
(setq make-backup-files nil)

;; set up backup stuff
;; (setq noback-regexp (concat "^" (regexp-opt
;; 				 '("^COMMIT_EDITMSG" "snd\."
;; 				   "^\.ido\.last"))))

;; (defun dont-backup-files (filename)
;;   (let ((filename-part (file-name-nondirectory filename)))
;;     (if (string-match noback-regexp filename-part)
;; 	nil
;;       (normal-backup-enable-predicate filename))))


;; (setq backup-enable-predicate 'dont-backup-files)

;; (setq
;;  backup-by-copying t
;;  backup-directory-alist '(("." . "~/.backups"))
;;  delete-old-versions t
;;  kept-new-versions 6
;;  kept-old-versions 2
;;  version-control t
;;  delete-old-versions t
;;  vc-make-backup-files t)

;; (defun force-backup-of-buffer ()
;;   (setq buffer-backed-up nil))

;; (add-hook 'before-save-hook  'force-backup-of-buffer)

(add-to-list 'auto-mode-alist '("/tmp/snd\\." . text-mode))
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG" . text-mode))

;; turn off higlighting
;; (global-font-lock-mode nil)

;; Use cperl mode instead of the default perl mode
(defalias 'perl-mode 'cperl-mode)

(setq tramp-default-method "ssh")
(setq require-final-newline 'query)
(setq initial-frame-alist '((width . 80)
      			    (height . 50)
			    (top + 50)
			    (tool-bar-lines . nil)))
(setq default-frame-alist initial-frame-alist)

(if (getenv "EMACS_LT")
    (progn (set-face-attribute 'default nil :height 80)
;;    (normal-erase-is-backspace-mode 1)
	   (push '(height . 40) initial-frame-alist))
  (push '(height . 50) initial-frame-alist))

(setq-default bc-bookmark-file (expand-file-name (concat user-emacs-directory "breadcrumb")))


;;(add-hook 'c-mode-hook 'turn-on-font-lock)

(add-hook 'text-mode-hook 'turn-on-auto-fill)

(setq window-system-default-frame-alist
       '((x (menu-bar-lines . 1) (tool-bar-lines . 0))
         (nil (menu-bar-lines . 0) (tool-bar-lines . 0))))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
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

(put 'downcase-region 'disabled nil)

(defun wfp5p-make-CR-do-indent ()
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))

;;(add-hook 'c-initialization-hook 'wfp5p-make-CR-do-indent)

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

;; (defun wfp-emerge-hook ()
;;   (yes-or-no-p "emerge hook ")
;; )

;; (add-hook 'emerge-startup-hook 'wfp-emerge-hook)

(setq rpm-spec-user-mail-address "wfp5p@worldbroken.com")

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
