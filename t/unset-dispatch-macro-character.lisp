;;;; test

;;; testing unset-dispatch-macro-character

(in-package #:unset-macro-character.test)

(5am:in-suite :dispatch-macro-character)

(5am:test :unset.current
  (let ((*readtable* #1=(copy-readtable nil)))
    (set-dispatch-macro-character #\# #\%
                                  (get-dispatch-macro-character #\# #\' *readtable*))

    (unset-dispatch-macro-character #\# #\%)

    (5am:is (equal (multiple-value-list (get-dispatch-macro-character #\# #\%))
                   (multiple-value-list (get-dispatch-macro-character #\# #\NEWLINE #1#))))))


(5am:test :unset.saved
  (let ((*readtable* #1=(copy-readtable nil))
        (rt #1#))
    (set-dispatch-macro-character #\# #\%
                                  (get-dispatch-macro-character #\# #\')
                                  rt)

    (unset-dispatch-macro-character #\# #\% rt)

    (5am:is (equal (multiple-value-list (get-dispatch-macro-character #\# #\% rt))
                   (multiple-value-list (get-dispatch-macro-character #\# #\NEWLINE #1#))))))

