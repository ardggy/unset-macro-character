;;;; -*- mode: lisp; encoding: utf-8 -*-
;;;; unset-macro-character.lisp - Unset macro character function from readtable.
;;;; URL: http://github.com/toshiabe/unset-macro-character
;;;; Copyright (c) 2011 Toshihisa Abe <toshihisa.abe@gmail.com>
;;;; Licence: MIT License

(in-package :unset-macro-character)

(defun unset-macro-character (#1=char &optional (#2=rt-designator *readtable*))
  "Unset macro-character function from given readtable."
  (setf (get-macro-character #1# #2#) (values nil nil)))

(defun unset-dispatch-macro-character (#1=dispatch-char #2=sub-char &optional (#3=rt-designator *readtable*))
  "Unset dispatch-macro-character-function from given readtable."
  (setf (get-dispatch-macro-character #1# #2# #3#) nil))

(defun remove-dispatch-macro-character (#1=dispatch-char &optional (#2=rt-designator *readtable*))
  "Remove dispatch-macro-character from given readtable."
  (set-syntax-from-char #1# #\NEWLINE #2# (copy-readtable nil)))

;;; Testing Part
(in-package :unset-macro-character.test)

(define-test unset-macro-character.current
  (let ((*readtable* (copy-readtable nil)))
    (set-macro-character #\[ (get-macro-character #\( ))
    (unset-macro-character #\[)
    (multiple-value-bind (macro-func non-term-p)
        (get-macro-character #\[)
      (assert-eql nil macro-func)
      (assert-eql nil non-term-p))))

(define-test unset-macro-character.saved-readtable
  (let ((rt (copy-readtable nil))
        (*readtable* (copy-readtable nil)))
    (set-macro-character #\[ (get-macro-character #\( ) nil rt)
    (unset-macro-character #\[ rt)
    (multiple-value-bind (macro-func non-term-p)
        (get-macro-character #\[ rt)
      (assert-eql nil macro-func)
      (assert-eql nil non-term-p))))

(define-test unset-dispatch-macro-character.current
  (let ((*readtable* (copy-readtable nil)))
    (set-dispatch-macro-character 
     #\# 
     #\!
     (get-dispatch-macro-character #\# #\' *readtable*))
    (unset-dispatch-macro-character #\# #\!)

    #+sbcl (assert-eql #'sb-impl::sharp-illegal
                       (get-dispatch-macro-character #\# #\!))
    #-sbcl (assert-eql t nil)))
 
(define-test unset-dispatch-macro-character.saved-readtable
  (let ((*readtable* (copy-readtable nil))
        (rt (copy-readtable nil)))
    (set-dispatch-macro-character 
     #\# 
     #\!
     (get-dispatch-macro-character #\# #\' *readtable*)
     rt)
    (lisp-unit:assert-true (readtablep rt))
    (unset-dispatch-macro-character #\# #\! rt)

    #+sbcl (assert-eql #'sb-impl::sharp-illegal
                       (get-dispatch-macro-character #\# #\! rt))
    #-sbcl (assert-eql t nil)))  ;; not implement yet

(define-test remove-dispatch-macro-character.current
  (let ((*readtable* (copy-readtable nil)))
    (make-dispatch-macro-character #\$ nil)
    (make-dispatch-macro-character #\% t)

    (multiple-value-bind (macro-function non-term-p)
        (get-macro-character #\$)
      (assert-eql #'sb-impl::read-dispatch-char macro-function)
      (assert-eql nil non-term-p))

    (multiple-value-bind (macro-function non-term-p)
        (get-macro-character #\%)
      (assert-eql #'sb-impl::read-dispatch-char macro-function)
      (assert-eql t non-term-p))
    
    (remove-dispatch-macro-character #\$)
    (remove-dispatch-macro-character #\%)
    (assert-eql nil (get-macro-character #\$))
    (assert-eql nil (get-macro-character #\%))))


(define-test remove-dispatch-macro-character.saved-readtable
  (let ((rt (copy-readtable nil)))
    (make-dispatch-macro-character #\$ nil rt)
    (make-dispatch-macro-character #\% t rt)
    (multiple-value-bind (macro-function non-term-p)
        (get-macro-character #\$ rt)
      (assert-eql #'sb-impl::read-dispatch-char macro-function)
      (assert-eql nil non-term-p))

    (multiple-value-bind (macro-function non-term-p)
        (get-macro-character #\% rt)
      (assert-eql #'sb-impl::read-dispatch-char macro-function)
      (assert-eql t non-term-p))
    (remove-dispatch-macro-character #\$ rt)
    (remove-dispatch-macro-character #\% rt)
    (assert-eql nil (get-macro-character #\$ rt))
    (assert-eql nil (get-macro-character #\% rt))))
