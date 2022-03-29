(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'ws-butler)
(add-hook 'cperl-mode-hook #'ws-butler-mode)
(add-hook 'c-mode-hook #'ws-butler-mode)
(add-hook 'python-mode-hook #'ws-butler-mode)

(require 'wfp5p-keys)

;; python mode
(defun wfp-python-mode-hook ()
  (define-abbrev-table 'python-mode-abbrev-table
    '(("pshebang" "#! /usr/bin/python")))
  (setq python-indent-offset 4))

(add-hook 'python-mode-hook #'wfp-python-mode-hook)
(add-hook 'python-mode-hook #'abbrev-mode)


;; cc-mode
(defun wfp-c-mode-hook ()
  ;;  (define-key c-mode-map "{" 'self-insert-command)
  (setq c-electric-flag t)
  (setq c-auto-newline t)
  (c-set-style "linux"))

(add-hook 'c-mode-common-hook #'wfp-c-mode-hook)

;; perl mode
(defalias 'perl-mode 'cperl-mode)
(defun wfp-cperl-mode-hook ()
  (setq cperl-electric-parens 'null
	cperl-invalid-face 'default
	cperl-electric-keywords 'null
	cperl-autoindent-on-semi t
	cperl-hairy t)
  (cperl-set-style "PerlStyle") ;; BSD
  (define-abbrev-table 'cperl-mode-abbrev-table
    '(("pshebang"   "#! /usr/bin/perl\n\nuse strict;\nuse feature ':5.10';")))
)
(add-hook 'cperl-mode-hook #'wfp-cperl-mode-hook)
(add-hook 'cperl-mode-hook #'abbrev-mode)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; set default font stuff
(set-face-attribute 'default nil
		    :family "Fira Code"
		    :foundry "CTDB"
		    :slant 'normal
		    :weight 'normal
		    :height 130
		    :width 'normal )

;; default frame size
(setq initial-frame-alist
   '((height . 50)
     (width . 80)
     (height . 50)
     (top + 50)
     (tool-bar-lines))
)

;; defaults
(setq-default
 default-frame-alist initial-frame-alist
 gnus-novice-user nil
 inhibit-startup-screen t
 initial-scratch-message nil
 isearch-lazy-highlight nil
 make-backup-files nil
 mouse-yank-at-point t
 remote-shell-program "ssh"
 require-final-newline 'query
 search-highlight t
 show-trailing-whitespace t
 gc-cons-threshold (* 8 1024 1024)  ; probably not needed
 tramp-default-method "ssh"
 tramp-syntax 'simplified
 tramp-verbose 8
 truncate-lines t
 uniquify-buffer-name-style 'post-forward
 rpm-spec-user-mail-address "wfp5p@worldbroken.com"
)
(fset 'yes-or-no-p 'y-or-n-p)
(put 'downcase-region 'disabled nil) ; Enable downcase-region
(put 'upcase-region 'disabled nil)   ; Enable upcase-region

;; turn off menu bar if not in X
(if (not (window-system))
    (menu-bar-mode -1)
)


;; This will be used so we don't see tramp and such
(defconst wfp-cache-directory
  (expand-file-name (concat user-emacs-directory ".cache/"))
  "Directory where all cache files should be saved.")

(defun wfp-cache-concat (name)
  "Return the absolute path of NAME under `wfp-cache-directory'."
  (let* ((directory (file-name-as-directory wfp-cache-directory))
         (path (convert-standard-filename (concat directory name))))
    (make-directory (file-name-directory path) t)
    path))

(with-eval-after-load 'tramp
  (setq tramp-persistency-file-name (wfp-cache-concat "tramp.eld")))
(with-eval-after-load 'abbrev
  (setq abbrev-file-name (wfp-cache-concat "abbrev_defs")))
(setq-default auto-save-list-file-prefix (wfp-cache-concat "auto-save-list/.saves-"))


(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG" . text-mode))
(add-hook 'text-mode-hook #'turn-on-auto-fill)

;; Ask on exit if more than 1 buffer
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

(add-hook 'kill-emacs-query-functions #'wfp-kill-emacs-query-function)

(load-theme 'wfp t)

; more gc tweaks that is probably overkill
(add-function :after after-focus-change-function
  (defun wfp-garbage-collect-maybe ()
    (unless (frame-focus-state)
      (garbage-collect))))
