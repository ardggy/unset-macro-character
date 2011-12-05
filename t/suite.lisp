;;; define suite

(in-package #:unset-macro-character.test)

;;; test hierarchy

(5am:def-suite :test)

(progn
  (5am:def-suite :macro-character :in :test)
  (5am:def-suite :dispatch-macro-character :in :test))

;;; end
