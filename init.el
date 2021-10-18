(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

; This is a bad idea, but it stops the annyoing compile window
; (setq byte-compile-warnings nil)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
; stop package from putting package-selected-packages in custom
(defun package--save-selected-packages (&rest opt) nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package t))
(setq-default
 use-package-always-defer t
 use-package-always-ensure t)

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq	auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package ws-butler
  :commands ws-butler-mode
  :init
  (add-hook 'cperl-mode-hook #'ws-butler-mode)
  (add-hook 'c-mode-hook #'ws-butler-mode)
)

(autoload 'describe-unbound-keys "unbound" "show unbound keys" t)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; set default font stuff
(set-face-attribute 'default nil
		    :family "Input Mono Narrow"
		    :foundry "FBI"
		    :slant 'normal
		    :weight 'normal
		    :height 98
		    :width 'semi-condensed )

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

(require 'wfp5p-cc)
(require 'wfp5p-keys)
(require 'wfp5p-cperl)
(require 'wfp5p-python)


;; Use cperl mode instead of the default perl mode
(defalias 'perl-mode 'cperl-mode)

(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG" . text-mode))
(add-hook 'text-mode-hook 'turn-on-auto-fill)

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

; more gc tweaks that is probably overkill
(add-function :after after-focus-change-function
  (defun wfp-garbage-collect-maybe ()
    (unless (frame-focus-state)
      (garbage-collect))))

