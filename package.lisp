;;;; package.lisp

(in-package :cl-user)

(defpackage #:unset-macro-character
  (:use #:cl)
  #+sbcl (:import-from #:sb-ext
                       #:without-package-locks)
  (:export #:unset-macro-character
           #:unset-dispatch-macro-character
           #:remove-dispatch-macro-character
           ))

(defpackage #:unset-macro-character.test
  (:use #:cl)
  (:import-from #:unset-macro-character
                #:unset-macro-character
                #:unset-dispatch-macro-character
                #:remove-dispatch-macro-character)
  (:import-from #:lisp-unit
                #:define-test
                #:assert-eql
                #:run-all-tests))
