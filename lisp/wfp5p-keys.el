(defun wfp5p-qr (from to)
  "Do a case sensitive query-replace"
  (interactive "sReplace:
sWith: ")
  (let ((case-fold-search nil))
    (query-replace from to)))

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
(define-key isearch-mode-map (kbd "C-x") 'isearch-yank-symbol)
(define-key global-map (kbd "M-d") 'kill-line)
(define-key global-map (kbd "M-s") 'save-buffer)
(define-key global-map (kbd "M-t") 'wfp5p-qr)
(define-key global-map (kbd "C-u") 'scroll-down)
(define-key global-map (kbd "M-u") 'universal-argument)
(define-key global-map (kbd "<f5>") 'goto-line)

;; (define-key global-map (kbd "C-x [") 'kmacro-start-macro)
;; (define-key global-map (kbd "C-x ]") 'kmacro-end-macro)

(defvar wfp5p-C-k-map
  (let ((keymap (make-sparse-keymap)))
    (mapc (function (lambda (kb) (define-key keymap (car kb) (cadr kb))))
	  (list '("c" copy-region-as-kill)
		'("f" search-forward)
		'("\C-k" kill-whole-line)
		'("k" kill-line)
		'("r" insert-file)
		'("\C-r" revert-buffer-quick)
		'("s" save-buffer)
		'("u" beginning-of-buffer)
		'("v" end-of-buffer)
		'("y" kill-region)
		'("z" zap-up-to-char)
		'("[" yank)
		'("]" kill-ring-save)
		'("#" comment-or-uncomment-region)
		'(";" comment-line)))
    keymap))
(define-key global-map "\C-k" wfp5p-C-k-map)

(provide 'wfp5p-keys)
