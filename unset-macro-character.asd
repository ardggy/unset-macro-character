;;;; unset-macro-character.asd

(in-package :cl-user)

(asdf:defsystem :unset-macro-character
  :version "0.1"
  :author "Toshihisa Abe"
  :license "MIT"
  :depends-on (#:lisp-unit)
  :serial t
  :components ((:file "package")
               (:file "defsetf")
               (:file "unset-macro-character"
                      :in-order-to ((asdf:compile-op (asdf:load-op "defsetf")))))
  :perform (asdf:test-op :before (op c)
                         (asdf:load-system :unset-macro-character))
  :perform (asdf:test-op :after (op c)
                         (lisp-unit:run-all-tests :unset-macro-character.test)))

