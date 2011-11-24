;;;; t.asd

(asdf:defsystem #:unset-macro-character.test
  :serial t
  :depends-on (#:unset-macro-character
               #:lisp-unit)
  :components ((:file "package")
               (:file "t")))

