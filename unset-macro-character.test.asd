;;;; asd

(in-package #:cl-user)

(asdf:defsystem #:unset-macro-character.test
  :depends-on (#:lisp-unit
               #:unset-macro-character)
  :serial t
  :components ((:file "package")
               (:module "t"
                        :components ((:file "t")))))
