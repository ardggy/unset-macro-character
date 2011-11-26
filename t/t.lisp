;;;; t.lisp

;;; Testing Part
(in-package #:unset-macro-character.test)

(define-test unset-macro-character.current
  (let ((*readtable* #1=(copy-readtable nil)))
    (set-macro-character #\[ (get-macro-character #\( ))
    (unset-macro-character #\[)

    (multiple-value-bind (f nt) (get-macro-character #\[)
      (assert-eql (values nil nil) (values f nt)))))


(define-test unset-macro-character.saved-readtable
  (let ((rt #1=(copy-readtable nil))
        (*readtable* #1#))
    (set-macro-character #\[ (get-macro-character #\( ) nil rt)
    (unset-macro-character #\[ rt)

    (multiple-value-bind (f nt) (get-macro-character #\[ rt)
      (assert-eql (values nil nil) (values f nt)))))


(define-test unset-dispatch-macro-character.current
  (let ((*readtable* #1=(copy-readtable nil)))
    (set-dispatch-macro-character #\# #\%
                                  (get-dispatch-macro-character #\# #\' *readtable*))

    (unset-dispatch-macro-character #\# #\%)

    (assert-eql (get-dispatch-macro-character #\# #\%)
                (get-dispatch-macro-character #\# #\NEWLINE #1#))))


(define-test unset-dispatch-macro-character.saved-readtable
  (let ((*readtable* #1=(copy-readtable nil))
        (rt #1#))
    (set-dispatch-macro-character #\# #\%
                                  (get-dispatch-macro-character #\# #\')
                                  rt)

    (unset-dispatch-macro-character #\# #\% rt)

    (assert-eql (get-dispatch-macro-character #\# #\% rt)
                (get-dispatch-macro-character #\# #\NEWLINE #1#))))


(define-test remove-dispatch-macro-character.current
  (let ((*readtable* #1=(copy-readtable nil)))

    (make-dispatch-macro-character #\$ nil)
    (multiple-value-bind (f nt) (get-macro-character #\$)
      (assert-eql (values (get-macro-character #\# #1#) nil)
                  (values f nt)))

    (make-dispatch-macro-character #\% t)
    (multiple-value-bind (f nt) (get-macro-character #\%)
      (assert-eql (values (get-macro-character #\# #1#) t)
                  (values f nt)))

    (remove-dispatch-macro-character #\$)
    (remove-dispatch-macro-character #\%)

    (multiple-value-bind (f nt) (get-macro-character #\$)
      (assert-eql (values nil nil) (values f nt)))

    (multiple-value-bind (f nt) (get-macro-character #\%)
      (assert-eql (values nil nil) (values f nt)))))

(define-test remove-dispatch-macro-character.saved-readtable
  (let ((rt #1=(copy-readtable nil)))

    (make-dispatch-macro-character #\$ nil rt)
    (multiple-value-bind (f nt) (get-macro-character #\$ rt)
      (assert-eql (values (get-macro-character #\# #1#) nil)
                  (values f nt)))

    (make-dispatch-macro-character #\% t rt)
    (multiple-value-bind (fn nt) (get-macro-character #\% rt)
      (assert-eql (values (get-macro-character #\# #1#) t)
                  (values fn nt)))

    (remove-dispatch-macro-character #\$ rt)
    (remove-dispatch-macro-character #\% rt)

    (multiple-value-bind (f nt)  (get-macro-character #\$ rt)
      (assert-eql (values nil nil) (values f nt)))

    (multiple-value-bind (f nt)  (get-macro-character #\% rt)
      (assert-eql (values nil nil) (values f nt)))))

