(require 'sequential-command)
(require 'thingatpt)

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

(defun wfp5p-qr (from to)
  "Do a case sensitive query-replace"
  (interactive "sReplace:
sWith: ")
  (let ((case-fold-search nil))
    (query-replace from to)))

(defun save-buffer-kill-buffer ()
  "Offer to save buffer, then kill it."
  (interactive)
  (basic-save-buffer)
  ;; (if (buffer-modified-p)
  ;;     (save-buffer))
  (kill-buffer))

(defun mark-end-of-line (&optional arg)
  "Put mark at end of line. If this command is repeated, it marks
the next ARG lines after the ones already marked."
  (interactive "p")
  (push-mark
   (save-excursion
     (if (and (eq last-command this-command) (mark t))
	 (goto-char (mark)))
     (end-of-line arg)
     (point))
   nil t))

(defun isearch-yank-symbol ()
  "Pull next symbol from buffer into search string."
  (interactive)
  (isearch-yank-string
   (save-excursion
     (and (not isearch-forward) isearch-other-end
          (goto-char isearch-other-end))
     (buffer-substring-no-properties
      (beginning-of-thing 'symbol) (end-of-thing 'symbol)))))


;; wfp5p key maps
(define-key isearch-mode-map "\C-x" 'isearch-yank-symbol)
(define-key global-map "\M-d" 'kill-line)
(define-key global-map "\M-s" 'save-buffer)
(define-key global-map "\M-t" 'wfp5p-qr)
(define-key global-map "\C-u" 'scroll-down)
(define-key global-map "\M-u" 'universal-argument)
(define-key global-map [f5] 'goto-line)

(define-key global-map "\C-x[" 'kmacro-start-macro)
(define-key global-map "\C-x]" 'kmacro-end-macro)


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
		'("s" save-buffer-kill-buffer)
		'("u" beginning-of-buffer)
		'("v" end-of-buffer)
		'("y" kill-region)
		'("z" zap-up-to-char)
		'("\C-k" wfp5p-nuke-auto-save)))
    keymap))

(define-key global-map "\C-k" wfp5p-C-k-map)
(provide 'wfp5p-keys)

