;;;; test

;;; testing unset-dispatch-macro-character

(in-package #:unset-macro-character.test)

(define-test #:unset-dispatch-macro-character.current
  (let ((*readtable* #1=(copy-readtable nil)))
    (set-dispatch-macro-character #\# #\%
                                  (get-dispatch-macro-character #\# #\' *readtable*))

    (unset-dispatch-macro-character #\# #\%)

    (assert-eql (get-dispatch-macro-character #\# #\%)
                (get-dispatch-macro-character #\# #\NEWLINE #1#))))


(define-test #:unset-dispatch-macro-character.saved-readtable
  (let ((*readtable* #1=(copy-readtable nil))
        (rt #1#))
    (set-dispatch-macro-character #\# #\%
                                  (get-dispatch-macro-character #\# #\')
                                  rt)

    (unset-dispatch-macro-character #\# #\% rt)

    (assert-eql (get-dispatch-macro-character #\# #\% rt)
                (get-dispatch-macro-character #\# #\NEWLINE #1#))))

