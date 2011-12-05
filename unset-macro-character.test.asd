;;;; unset-macro-character.test.asd

(in-package #:cl-user)

(asdf:defsystem #:unset-macro-character.test
  :serial t
  :depends-on (#:fiveam
               #:unset-macro-character)
  :components ((:file "package")
               (:module "t"
                        :components ((:file "suite")
                                     (:file "unset-macro-character")
                                     (:file "unset-dispatch-macro-character")
                                     (:file "remove-dispatch-macro-character")))))
