(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; treesit stuff
(when (and (fboundp 'treesit-available-p)
	   (treesit-available-p))
  (use-package treesit-auto
    :custom
    (treesit-auto-install 'prompt)
    :config
    (setq treesit-auto-langs '(bash python toml json))
    (global-treesit-auto-mode)))

;; which-key
(setq which-key-show-early-on-C-h t)
(setq which-key-idle-delay 10000)
(setq which-key-idle-secondary-delay 0.05)
(which-key-mode)


(require 'ws-butler)
(add-hook 'cperl-mode-hook #'ws-butler-mode)
(add-hook 'c-mode-hook #'ws-butler-mode)
(add-hook 'python-mode-hook #'ws-butler-mode)

(require 'wfp5p-keys)
(require 'wfp5p-skels)

;; python mode
(setq python-indent-guess-indent-offset-verbose nil)
(defun wfp-python-mode-hook ()
  (add-to-list 'default-frame-alist '(width . 100))
  (setq python-indent-offset 4))
(add-hook 'python-mode-hook #'wfp-python-mode-hook)

(setq python-ts-mode-hook python-mode-hook)

;; Work this out, it's a lot of old
;; cc-mode
(c-add-style
 "wfp-c-style"
 '("linux"
   (c-basic-offset . 4)
   ))

(defun wfp-c-mode-hook ()
  (c-set-style "wfp-c-style")
  )

(add-hook 'c-mode-common-hook 'wfp-c-mode-hook)

(dir-locals-set-class-variables
 'linux-c-mode
 '((c-mode . ((c-basic-offset . 8)))))

(dir-locals-set-directory-class
 "/lv1/work/kernel" 'linux-c-mode)

;; perl mode
(defalias 'perl-mode 'cperl-mode)
(defun wfp-cperl-mode-hook ()
  (setq cperl-electric-parens 'null
	cperl-invalid-face 'default
	cperl-electric-keywords 'null
	cperl-autoindent-on-semi t
	cperl-hairy t)
  (cperl-set-style "PerlStyle") ;; BSD
)
(add-hook 'cperl-mode-hook #'wfp-cperl-mode-hook)


(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; set default font stuff
(set-face-attribute 'default nil
		    :family "Fira Code"
		    :foundry "CTDB"
		    :slant 'normal
		    :weight 'medium
		    :height 128
		    :width 'normal )


;; defaults
(setq-default
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
 tramp-default-method "ssh"
 tramp-syntax 'simplified
 tramp-verbose 8
 tramp-allow-unsafe-temporary-files t
 truncate-lines t
;; uniquify-buffer-name-style 'post-forward
 visible-bell t
 rpm-spec-user-mail-address "wfp5p@worldbroken.com"
)

(fset 'yes-or-no-p 'y-or-n-p)
(put 'downcase-region 'disabled nil) ; Enable downcase-region
(put 'upcase-region 'disabled nil)   ; Enable upcase-region

;; turn off menu bar if not in X
;; good enough if not using emacs daemon
;; (unless (display-graphic-p)
;;    (menu-bar-mode -1))

;; more complicated method for emacs daemon
(defun contextual-menubar (&optional frame)
  "Display the menubar in FRAME (default: selected frame) if on a
    graphical display, but hide it if in terminal."
  (interactive)
  (set-frame-parameter frame 'menu-bar-lines
                             (if (display-graphic-p frame)
                                  1 0)))

(add-hook 'after-make-frame-functions #'contextual-menubar)
(add-hook 'after-init-hook #'contextual-menubar)


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

(add-to-list 'auto-mode-alist '("\\.bu\\'" . yaml-mode))
(add-hook 'yaml-mode-hook #'turn-off-auto-fill)

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

