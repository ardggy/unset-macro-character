;;;; test

;;; testing unset-macro-character
;;; *readtable* and lexical bound readtable

(in-package #:unset-macro-character.test)

(5am:in-suite :macro-character)

(5am:test :unset.current
  (let ((*readtable* #1=(copy-readtable nil)))
    (set-macro-character #\[ (get-macro-character #\( ))
    (unset-macro-character #\[)

    (multiple-value-bind (f nt) (get-macro-character #\[)
      (5am:is (equal (multiple-value-list (get-macro-character #\[ #1#))
                     (multiple-value-list (values f nt)))))))

(5am:test :unset.saved
  (let ((rt #1=(copy-readtable nil))
        (*readtable* #1#))
    (set-macro-character #\[ (get-macro-character #\( ) nil rt)
    (unset-macro-character #\[ rt)

    (multiple-value-bind (f nt) (get-macro-character #\[ rt)
      (5am:is (equal (multiple-value-list (get-macro-character #\[ rt))
                     (multiple-value-list (values f nt)))))))

