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

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(setq default-frame-alist initial-frame-alist)

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

(autoload 'turn-on-ws-trim "ws-trim" "turn on wstrim" t)
(autoload 'turn-off-ws-trim "ws-trim" "turn off wstrim" t)

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

(fset 'yes-or-no-p 'y-or-n-p)

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
