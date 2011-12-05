;;;; unset-macro-character.asd

(in-package #:cl-user)

(asdf:defsystem #:unset-macro-character
  :version "0.5"
  :author "Toshihisa Abe"
  :license "MIT"
  :serial t
  :depends-on (#:fiveam)
  :components ((:file "package")
               (:file "nilf")
               (:file "unset-macro-character"))
  :perform (asdf:test-op :before (op c)
                         (let ((*readtable* (copy-readtable nil)))
                           (asdf:load-system :unset-macro-character.test)))
  :perform (asdf:test-op :after (op c)
                         (funcall (intern "RUN!" :5am) :test)))

