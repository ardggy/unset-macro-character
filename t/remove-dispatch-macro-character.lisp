;;;; remove-dispatch-macro-character.lisp

;;; testing remove-dispatch-macro-character.lisp

(in-package #:unset-macro-character.test)

(define-test #:remove-dispatch-macro-character.current
  (let ((*readtable* #1=(copy-readtable nil)))

    (make-dispatch-macro-character #\$ nil)
    (multiple-value-bind (f nt) (get-macro-character #\$ *readtable*)
      #+(or sbcl cmu ccl ecl)
      (assert-eql (values (get-macro-character #\# #1#) nil)
                  (values f nt))
      #+clisp
      (assert-eql (values t nil) (values (functionp f) nt))
      )

    (make-dispatch-macro-character #\% t)
    (multiple-value-bind (fn nt) (get-macro-character #\% *readtable*)
      #+(or sbcl cmu ccl ecl)
      (assert-eql (values (get-macro-character #\# #1#) t)
                  (values fn nt))
      #+clisp
      (assert-eql (values t t) (values (functionp fn) nt))
      )

    (remove-dispatch-macro-character #\$)
    (remove-dispatch-macro-character #\%)

    (multiple-value-bind (f nt) (get-macro-character #\$ *readtable*)
      (assert-eql (get-macro-character #\$ #1#) (values f nt)))

    (multiple-value-bind (f nt) (get-macro-character #\% *readtable*)
      (assert-eql (get-macro-character #\% #1#) (values f nt)))))

(define-test #:remove-dispatch-macro-character.saved-readtable
  (let ((rt #1=(copy-readtable nil)))

    (make-dispatch-macro-character #\$ nil rt)

    (multiple-value-bind (f nt) (get-macro-character #\$ rt)
      #+(or sbcl cmu ccl ecl)
      (assert-eql (values (get-macro-character #\# #1#) nil)
                  (values f nt))
      #+clisp
      (assert-eql (values t nil) (values (functionp f) nt))
      )


    (make-dispatch-macro-character #\% t rt)

    (multiple-value-bind (f nt) (get-macro-character #\% rt)
      #+(or sbcl cmu ccl ecl)
      (assert-eql (values (get-macro-character #\# #1#) t)
                  (values f nt))
      #+clisp (assert-eql (values t t) (values (functionp f) nt))
      )

    (remove-dispatch-macro-character #\$ rt)
    (remove-dispatch-macro-character #\% rt)

    (multiple-value-bind (f nt) (get-macro-character #\$ rt)
      (assert-eql (get-macro-character #\$ #1#) (values f nt)))

    (multiple-value-bind (f nt) (get-macro-character #\% rt)
      (assert-eql (get-macro-character #\% #1#) (values f nt)))))

