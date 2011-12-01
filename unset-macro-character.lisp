;;;; -*- mode: lisp; encoding: utf-8 -*-
;;;; unset-macro-character.lisp - Unset macro character function from readtable.
;;;; URL: http://github.com/toshiabe/unset-macro-character
;;;; Copyright (c) 2011 Toshihisa Abe <toshihisa.abe@gmail.com>
;;;; License: MIT License

(in-package #:unset-macro-character)

(defun unset-macro-character (#1=char &optional (#2=*readtable* *readtable*))
  "Unset macro-character function from given readtable."
  (set-syntax-from-char #1# #1# #2# (copy-readtable nil)))

(defun unset-dispatch-macro-character (#1=dispatch-char #2=sub-char &optional (#3=*readtable* *readtable*))
  "Unset dispatch-macro-character-function from given readtable."
  (set-dispatch-macro-character #1# #2# (get-dispatch-macro-character #\# illc (copy-readtable nil)) #3#))

;;; complement of `make-dispatch-macro-character'
(defun remove-dispatch-macro-character (#1=dispatch-char &optional (#2=*readtable* *readtable*))
  "Remove dispatch-macro-character from given readtable."
  (unset-macro-character #1# #2#))

