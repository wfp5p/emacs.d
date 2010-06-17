 (add-to-list 'load-path user-emacs-directory)

(require 'wfp5p-cc)
(require 'wfp5p-keys)
(require 'wfp5p-cperl)

;; turn on ido just for buffer ops
(unless noninteractive
	(ido-mode 'buffer))

(autoload 'turn-on-ws-trim "ws-trim" "turn on wstrim" t)
(autoload 'turn-off-ws-trim "ws-trim" "turn off wstrim" t)

(autoload 'describe-unbound-keys "unbound" "show unbound keys" t)

(autoload 'hide-lines "hide-lines" "Hide lines based on a regexp" t)

(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)
(setq ack-prompt-for-directory t)

(defalias 'yes-or-no-p 'y-or-n-p)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ack-arguments (quote ("--nopager")))
 '(ack-use-environment nil)
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

;; set up backup stuff
(setq noback-regexp (concat "^" (regexp-opt
				 '("^COMMIT_EDITMSG" "snd\."
				   "^\.ido\.last"))))

(defun dont-backup-files (filename)
  (let ((filename-part (file-name-nondirectory filename)))
    (if (string-match noback-regexp filename-part)
	nil
      (normal-backup-enable-predicate filename))))


(setq backup-enable-predicate 'dont-backup-files)

(setq
 backup-by-copying t
 backup-directory-alist '(("." . "~/.backups"))
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t
 delete-old-versions t
 vc-make-backup-files t)

(defun force-backup-of-buffer ()
  (setq buffer-backed-up nil))

(add-hook 'before-save-hook  'force-backup-of-buffer)

(add-to-list 'auto-mode-alist '("/tmp/snd\\." . text-mode))
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG" . text-mode))

;; turn off higlighting
;; (global-font-lock-mode nil)

(fset 'perl-mode 'cperl-mode)

;;(setq tramp-default-method "scpc")
(setq require-final-newline 'query)
(setq initial-frame-alist '((width . 80)
      			    (height . 50)
			    (top + 50)
			    (tool-bar-lines . nil)))
(setq default-frame-alist initial-frame-alist)

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
 '(cperl-nonoverridable-face ((((class color) (background light)) (:foreground "green"))))
 '(font-lock-builtin-face ((((class color) (min-colors 88) (background light)) (:foreground "magenta"))))
 '(font-lock-comment-face ((((class color) (min-colors 88) (background light)) (:foreground "red2"))))
 '(font-lock-keyword-face ((((class color) (min-colors 8)) (:foreground "blue" :weight normal))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background light)) nil)))
 '(font-lock-type-face ((((class color) (min-colors 88) (background light)) (:foreground "khaki4"))))
 '(font-lock-variable-name-face ((((class color) (min-colors 88) (background light)) (:foreground "NavyBlue")))))

(defun wfp5p-replace-typedef (from-str to-str)
   "Delete the following character up to next close paren"
   (interactive "sReplace string: \ns%s becomes: ")
   (setq search-string (concat "\\b" from-str "\\b"))
   (save-excursion
     (while (re-search-forward search-string nil t)
       (replace-match to-str t t))))

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
