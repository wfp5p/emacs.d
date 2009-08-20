(add-to-list 'load-path user-emacs-directory)


(require 'wfp5p-cc)
(require 'wfp5p-keys)
(require 'wfp5p-cperl)

(autoload 'turn-on-ws-trim "ws-trim" "turn on wstrim" t)
(autoload 'turn-off-ws-trim "ws-trim" "turn off wstrim" t)

(autoload 'describe-unbound-keys "unbound" "show unbound keys" t)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(backup-directory-alist (quote ((".*" . "~/.backups"))))
 '(delete-old-versions t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(isearch-lazy-highlight nil)
 '(remote-shell-program "ssh")
 '(search-highlight t)
 '(show-trailing-whitespace t)
 '(tool-bar-mode nil nil (tool-bar))
 '(transient-mark-mode t)
 '(truncate-lines t)
 '(version-control t))

(add-to-list 'auto-mode-alist '("/tmp/snd\\." . text-mode))
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG" . text-mode))

;; turn off higlighting
;; (global-font-lock-mode nil)

(fset 'perl-mode 'cperl-mode)

;; (keyboard-translate ?\C-h ?\C-?)
;; (global-set-key "\C-h" 'backward-delete-char)

(setq auto-save-file-name-transforms
   `((".*" ,temporary-file-directory t)))

(setq tramp-default-method "scpc")
(setq require-final-newline 'query)
(setq initial-frame-alist '((width . 80)
      			    (height . 50)
			    (top + 50)
			    (tool-bar-lines . nil)))
(setq default-frame-alist initial-frame-alist)

(setq-default bc-bookmark-file (expand-file-name (concat user-emacs-directory "breadcrumb")))


;;(add-hook 'c-mode-hook 'turn-on-font-lock)

(add-hook 'text-mode-hook 'turn-on-auto-fill)

(if (not (window-system))
    (add-to-list 'initial-frame-alist '(menu-bar-lines . 0)))

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

