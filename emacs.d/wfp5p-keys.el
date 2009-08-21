(require 'sequential-command)

(autoload 'zap-up-to-char "misc" "zap up to char" t)

;; breadcrumbs
(autoload 'bc-set "breadcrumb" "Set bookmark in current point." t)
(autoload 'bc-previous "breadcrumb" "Go to previous bookmark." t)
(autoload 'bc-next "breadcrumb" "Go to next bookmark."  t)
(autoload 'bc-local-previous "breadcrumb" "Go to previous local bookmark."  t)
(autoload 'bc-local-next "breadcrumb" "Go to next local bookmark."  t)
(autoload 'bc-goto-current "breadcrumb" "Go to the current bookmark."  t)
(autoload 'bc-list "breadcrumb" "List all bookmarks in menu mode." t)
(autoload 'bc-clear "breadcrumb" "Clear all bookmarks."  t)

(defun wfp5p-nuke-auto-save ()
  "Delete the current buffers auto-save file."
  (interactive)
  (delete-auto-save-file-if-necessary t))

;; wfp5p key maps
(define-key global-map "\M-d" 'kill-line)
(define-key global-map "\M-s" 'save-buffer)
(define-key global-map "\M-t" 'query-replace)
(define-key global-map "\C-u" 'scroll-down)
(define-key global-map "\M-u" 'univeral-argument)
(define-key global-map [f5] 'goto-line)

(define-key global-map [home] 'seq-home)

(define-sequential-command seq-end
  end-of-line end-of-buffer seq-return)

(define-key global-map [end] 'seq-end)

(defvar wfp5p-bread-map
  (let ((keymap (make-sparse-keymap)))
    (mapc (function (lambda (kb) (define-key keymap (car kb) (cadr kb))))
	  (list '("b" bc-set)
		'("n" bc-next)
		'("p" bc-previous)
		'("c" bc-clear)
		'("l" bc-list)
		'(" " bc-goto-current)))
    keymap))

(defvar wfp5p-C-k-map
  (let ((keymap (make-sparse-keymap)))
    (mapc (function (lambda (kb) (define-key keymap (car kb) (cadr kb))))
	  (list (list "b" wfp5p-bread-map)
		'("c" copy-region-as-kill)
		'("f" search-forward)
		'("k" kill-line)
		'("r" insert-file)
		'("u" beginning-of-buffer)
		'("v" end-of-buffer)
		'("y" kill-region)
		'("z" zap-up-to-char)
		'("\C-k" wfp5p-nuke-auto-save)))
    keymap))

(define-key global-map "\C-k" wfp5p-C-k-map)
(provide 'wfp5p-keys)
