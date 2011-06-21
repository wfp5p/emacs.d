(defconst emerge-help-message
  "Merge commands for Fast mode; in Edit mode, precede them with C-c C-c

p   Select the previous difference.
n   Select the next difference.
a   Choose the A version of this difference.
b   Choose the B version of this difference.
.   Select the difference containing point.
q   Quit—finish the merge.
C-u n j Select difference number n.
C-] Abort—exit merging and do not save the output.
f   Go into Fast mode. (In Edit mode, this is actually C-c C-c f.)
e   Go into Edit mode.
l   Recenter (like C-l) all three windows. With an argument,
    reestablish the default three-window display.

d a  Choose the A version as the default from here down in the merge buffer.
d b  Choose the B version as the default from here down in the merge buffer.
c a  Copy the A version of this difference into the kill ring.
c b  Copy the B version of this difference into the kill ring.
i a  Insert the A version of this difference at point.
i b  Insert the B version of this difference at point.
m    Put point and mark around the difference.

^    Scroll all three windows down (like M-v).
v    Scroll all three windows up (like C-v).
<    Scroll all three windows left (like C-x <).
>    Scroll all three windows right (like C-x >).
|    Reset horizontal scroll on all three windows.

x 1  Shrink the merge window to one line. (Use C-u l to restore it to
       full size.)
x c  Combine the two versions of this difference (see Combining in Emerge).
x f  Show the names of the files/buffers Emerge is operating on, in a
         Help window. (Use C-u l to restore windows.)
x j  Join this difference with the following one.
         (C-u x j joins this difference with the previous one.)
x s  Split this difference into two differences.
x t  Trim identical lines off the top and bottom of the difference.
            Such lines occur when the A and B versions are identical
            but differ from the ancestor version. "
)

(defconst emerge-help-frame-parameters
  (list
   '(name . "emerge-help")
   ;;'(unsplittable . t)
   '(minibuffer . nil)
   '(user-position . t)	      ; Emacs only
   '(vertical-scroll-bars . nil)  ; Emacs only
   '(menu-bar-lines . 0)          ; Emacs only
   '(tool-bar-lines . 0)          ; Emacs 21+ only
   '(left-fringe    . 0)
   '(right-fringe   . 0)
   ;; make initial frame small to avoid distraction
   ;;   '(width . 1) '(height . 1)
   )
)


(defun emerge-help-create-buffer ()
  (kill-all-local-variables)
  (buffer-disable-undo)
  (insert emerge-help-message)
  (setq buffer-read-only t))

(defun emerge-help-get-help-buffer ()
  "Return the emerge Help buffer.  Make it first if necessary."
  (let ((buf (get-buffer "*EMERGE Help*")))
    (if buf
	nil
      (setq buf (get-buffer-create "*EMERGE Help*"))
      (with-current-buffer buf
	(emerge-help-create-buffer)))
    buf))

(defun emerge-help-show-help-frame ()
  "Show the help frame, creating it if necessary."
  (let ((help-frame)
	(help-buffer (emerge-help-get-help-buffer)))
    (setq help-frame (make-frame emerge-help-frame-parameters))
    (select-frame help-frame)
    (switch-to-buffer help-buffer)
    )
)
