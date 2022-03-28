(deftheme wfp)

(custom-theme-set-faces
 'wfp
 '(font-lock-builtin-face ((((class color) (min-colors 88) (background light)) (:foreground "magenta"))))
 '(font-lock-comment-face ((((class color) (min-colors 88) (background light)) (:foreground "red2"))))
 '(font-lock-keyword-face ((((class color) (min-colors 88) (background light)) (:foreground "blue"))))
 '(font-lock-variable-name-face ((((class color) (min-colors 88) (background light)) (:foreground "NavyBlue"))))
 '(font-lock-string-face ((t (:foreground "dark magenta"))))
 '(cperl-nonoverridable-face ((t (:foreground "dark green"))))
 '(cperl-hash-face ((t (:foreground "Red"))))
 '(region ((t (:background "gray85" :foreground "black")))))

(provide-theme 'wfp)
