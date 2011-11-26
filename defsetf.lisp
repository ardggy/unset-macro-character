;;;; defsetf to get-macro-character, get-dispatch-macro-character

(in-package :unset-macro-character)

#+sbcl
(sb-ext:without-package-locks
  (defsetf get-macro-character
      (char &optional (rt-designator *readtable*))
      (func non-term-p)
    `(if ,func
         (progn
           (set-macro-character ,char ,func ,non-term-p ,rt-designator)
           t)
         (progn
           (set-syntax-from-char ,char ,char ,rt-designator (copy-readtable nil))
           t)))

  (defsetf get-dispatch-macro-character
      (disp-char sub-char &optional (rt-designator *readtable*))
      (func)
    `(if ,func
         (progn
           (set-dispatch-macro-character ,disp-char ,sub-char ,func ,rt-designator)
           t)
         (progn
           (set-dispatch-macro-character ,disp-char ,sub-char
                                         (get-dispatch-macro-character
                                          #\#
                                          #\NEWLINE ;; illegal-dispatch
                                          (copy-readtable nil))
                                         ,rt-designator)
           t))))

#-sbcl
(progn
  (defsetf get-macro-character
      (char &optional (rt-designator *readtable*))
      (func non-term-p)
    `(if ,func
         (progn
           (set-macro-character ,char ,func ,non-term-p ,rt-designator)
           t)
         (progn
           (set-syntax-from-char ,char ,char ,rt-designator (copy-readtable nil))
           t)))

  (defsetf get-dispatch-macro-character
      (disp-char sub-char &optional (rt-designator *readtable*))
      (func)
    `(if ,func
         (progn
           (set-dispatch-macro-character ,disp-char ,sub-char ,func ,rt-designator)
           t)
         (progn
           (set-dispatch-macro-character ,disp-char ,sub-char
                                         (get-dispatch-macro-character
                                          #\#
                                          #\NEWLINE
                                          (copy-readtable nil))
                                         ,rt-designator)
           t))))

