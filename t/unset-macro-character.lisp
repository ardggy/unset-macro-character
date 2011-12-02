;;;; test

;;; testing unset-macro-character

(in-package #:unset-macro-character.test)

(define-test #:current
  (let ((*readtable* #1=(copy-readtable nil)))
    (set-macro-character #\[ (get-macro-character #\( ))
    (unset-macro-character #\[)

    (multiple-value-bind (f nt) (get-macro-character #\[)
      (assert-eql (get-macro-character #\[ #1#)
                  (values f nt)))))

(define-test #:saved
  (let ((rt #1=(copy-readtable nil))
        (*readtable* #1#))
    (set-macro-character #\[ (get-macro-character #\( ) nil rt)
    (unset-macro-character #\[ rt)

    (multiple-value-bind (f nt) (get-macro-character #\[ rt)
      (assert-eql (get-macro-character #\[ #1#)
                  (values f nt)))))

