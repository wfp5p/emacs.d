(require 'sequential-command)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(autoload 'zap-up-to-char "misc" "zap up to char" t)

(defun wfp5p-revert-buffer ()
  "Do revert-buffer on current buffer."
  (interactive)
  (revert-buffer nil t t)
  (message (concat "Reverted buffer " (buffer-name))))

(defun wfp5p-nuke-auto-save ()
  "Delete the current buffers auto-save file."
  (interactive)
  (delete-auto-save-file-if-necessary t)
  (message (concat "Nuked autosave for " (buffer-name))))

(defun wfp5p-qr (from to)
  "Do a case sensitive query-replace"
  (interactive "sReplace:
sWith: ")
  (let ((case-fold-search nil))
    (query-replace from to)))

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
(define-key global-map [f7] 'wfp5p-revert-buffer)

(define-key global-map "\C-x[" 'kmacro-start-macro)
(define-key global-map "\C-x]" 'kmacro-end-macro)

(define-sequential-command seq-home
  beginning-of-line beginning-of-buffer sequential-command-return)

(define-key global-map [home] 'seq-home)

(define-sequential-command seq-end
  end-of-line end-of-buffer sequential-command-return)

(define-key global-map [end] 'seq-end)

(defvar wfp5p-C-k-map
  (let ((keymap (make-sparse-keymap)))
    (mapc (function (lambda (kb) (define-key keymap (car kb) (cadr kb))))
	  (list '("c" copy-region-as-kill)
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

;; (defun revert-all-buffers ()
;;           "Refreshes all open buffers from their respective files"
;;           (interactive)
;;           (let* ((list (buffer-list))
;;                  (buffer (car list)))
;;             (while buffer
;;               (when (and (buffer-file-name buffer)
;;                          (not (buffer-modified-p buffer)))
;;                 (set-buffer buffer)
;;                 (revert-buffer t t t))
;;               (setq list (cdr list))
;;               (setq buffer (car list))))
;;           (message "Refreshed open files"))
