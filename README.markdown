
UNSET-MACRO-CHARACTER
=====================

UNSET-MACRO-CHARACTER is a operator to unregister the macro character in a readtable.

Run under following implementations, SBCL, CMUCL and Clozure CL.

It is risky to modify the runtime readtable, so use at your own risk.

UNSET-MACRO-CHARACTER はリードテーブル中のマクロ文字登録を削除するためのオペレータです。

SBCL, CMUCL, Clozure CL での動作を確認しています。

リードテーブルを変更するのはそれなりにリスクのあることです。

危険性を理解した上で、自己責任での使用でお願いします。


Export
------
* Function: `unset-macro-character`
* Function: `unset-dispatch-macro-character`
* Function: `remove-dispatch-macro-charater`

Test
----

    (asdf:test-system :unset-macro-character)


Run under following implementations (require `lisp-unit`):

以下の実装でのテストを行っています。(`lisp-unit` でテストしています)

* SBCL 1.0.53
* CMUCL 20b, 20c
* Clozure CL 1.6, 1.7


Usage
-----

#### Function: `unset-macro-character char (&optional *readtable*)`


Unset the #\' from current readtable.

現在のリードテーブルからクオートマクロ文字を削除します。

    (unset-macro-character #\')

You can unset macro-character from readtable explicitly.

リードテーブルを指定して削除を行うこともできます。

    (let ((rt *readtable*))
      (unset-macro-character #\[ rt))



#### Function: `unset-dispatch-macro-character disp-char char (&optional *readtable*)`


Unset the #\# #\' from current readtable.

現在のリードテーブルから #' ディスパッチマクロ文字を削除します。

    (unset-macro-dispatch-macro-character #\# #\')

You can unset dispatch-macro-character from readtable explicitly.

リードテーブルを指定して削除を行うこともできます。


    (let ((rt *readtable*))
      (unset-dispatch-macro-character #\# #\( rt))


#### Function: `remove-dispatch-macro-character disp-char (&optional *readtable*)`


Remove the dispatch-character from current readtable.

現在のリードテーブルから # ディスパッチ文字を削除します。


    (remove-dispatch-macro-character #\#)

You can remove dispatch-character from readtable explicitly.

リードテーブルを指定して削除を行うこともできます。


    (let ((rt *readtable*))
      (remove-dispatch-macro-character #\# rt))


NOTE
====

Current implement UNSET-MACRO-CHARACTER with `SET-SYNTAX-FROM-CHAR`.

UNSET-MACRO-CHARACTER の実装には `SET-SYNTAX-FROM-CHAR` を利用しています。


LICENSE
=======

MIT License.

----

Thank you for reading.

----
Copyright (C) 2011 Toshihisa Abe <<toshihisa.abe@gmail.com>>
