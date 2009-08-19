(require 'sequential-command)

(autoload 'zap-up-to-char "misc" "zap up to char" t)

;; wfp5p key maps
(define-key global-map "\M-d" 'kill-line)
(define-key global-map "\M-s" 'save-buffer)
(define-key global-map "\C-u" 'scroll-down)
(define-key global-map [f5] 'goto-line)

(define-key global-map [home] 'seq-home)

(define-sequential-command seq-end
  end-of-line end-of-buffer seq-return)

(define-key global-map [end] 'seq-end)

(defvar wfp5p-C-k-map nil "")

(setq wfp5p-C-k-map (make-keymap))
(define-key global-map "\C-k" wfp5p-C-k-map)
(define-key wfp5p-C-k-map "c" 'copy-region-as-kill)
;;(define-key wfp5p-C-k-map "f" 'find-file)
(define-key wfp5p-C-k-map "f" 'search-forward)
(define-key wfp5p-C-k-map "k" 'kill-line)
(define-key wfp5p-C-k-map "r" 'insert-file)
(define-key wfp5p-C-k-map "u" 'beginning-of-buffer)
(define-key wfp5p-C-k-map "v" 'end-of-buffer)
(define-key wfp5p-C-k-map "y" 'kill-region)
(define-key wfp5p-C-k-map "z" 'zap-up-to-char)

(provide 'wfp5p-keys)
