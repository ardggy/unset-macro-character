;;;; package.lisp

(in-package #:cl-user)

(defpackage #:unset-macro-character
  (:use #:cl)
  (:export #:unset-macro-character
           #:unset-dispatch-macro-character
           #:remove-dispatch-macro-character))

(defpackage #:unset-macro-character.test
  (:use #:cl)
  (:import-from #:unset-macro-character
                #:unset-macro-character
                #:unset-dispatch-macro-character
                #:remove-dispatch-macro-character))
