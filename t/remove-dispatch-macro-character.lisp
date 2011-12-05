;;;; remove-dispatch-macro-character.lisp

;;; testing remove-dispatch-macro-character.lisp
;;; @todo: too complex

(in-package #:unset-macro-character.test)

(5am:in-suite :dispatch-macro-character)

(5am:test :remove.current
  (let ((*readtable* #1=(copy-readtable nil)))

    (make-dispatch-macro-character #\$ nil)
    (multiple-value-bind (f nt) (get-macro-character #\$ *readtable*)
      #+(or SBCL CMU CCL ECL)
      (5am:is (equal (multiple-value-list (values (get-macro-character #\# #1#) nil))
                     (multiple-value-list (values f nt))))
      #+CLISP
      (5am:is (equal (multiple-value-list (values t nil))
                     (multiple-value-list (values (functionp f) nt))))
      )

    (make-dispatch-macro-character #\% t *readtable*)
    (multiple-value-bind (fn nt) (get-macro-character #\% *readtable*)
      #+(or SBCL CMU CCL ECL)
      (5am:is (equal (multiple-value-list (values (get-macro-character #\# #1#) t))
                     (multiple-value-list (values fn nt))))
      #+CLISP
      (5am:is (equal (multiple-value-list (values t t))
                     (multiple-value-list (values (functionp fn) nt))))
      )

    (remove-dispatch-macro-character #\$)
    (remove-dispatch-macro-character #\%)

    (multiple-value-bind (f nt) (get-macro-character #\$ *readtable*)
      (5am:is (equal (multiple-value-list (get-macro-character #\$ #1#))
                     (multiple-value-list (values f nt)))))

    (multiple-value-bind (f nt) (get-macro-character #\% *readtable*)
      (5am:is (equal (multiple-value-list (get-macro-character #\% #1#))
                     (multiple-value-list (values f nt)))))))

(5am:test :remove.saved
  (let ((rt #1=(copy-readtable nil)))

    (make-dispatch-macro-character #\$ nil rt)
    (multiple-value-bind (f nt) (get-macro-character #\$ rt)
      #+(or SBCL CMU CCL ECL)
      (5am:is (equal (multiple-value-list (values (get-macro-character #\# #1#) nil))
                     (multiple-value-list (values f nt))))
      #+CLISP
      (5am:is (equal (multiple-value-list (values t nil))
                     (multiple-value-list (values (functionp f) nt))))
      )

    (make-dispatch-macro-character #\% t rt)
    (multiple-value-bind (fn nt) (get-macro-character #\% rt)
      #+(or SBCL CMU CCL ECL)
      (5am:is (equal (multiple-value-list (values (get-macro-character #\# #1#) t))
                     (multiple-value-list (values fn nt))))
      #+CLISP
      (5am:is (equal (multiple-value-list (values t t))
                     (multiple-value-list (values (functionp fn) nt))))
      )

    (remove-dispatch-macro-character #\$ rt)
    (remove-dispatch-macro-character #\% rt)

    (multiple-value-bind (fn nt) (get-macro-character #\$ rt)
      (5am:is (equal (multiple-value-list (get-macro-character #\$ #1#))
                     (multiple-value-list (values fn nt)))))

    (multiple-value-bind (e nt) (get-macro-character #\% rt)
      (5am:is (equal (multiple-value-list (get-macro-character #\% #1#))
                     (multiple-value-list (values e nt)))))))

