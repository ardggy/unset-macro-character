
UNSET-MACRO-CHARACTER
=====================

UNSET-MACRO-CHARACTER is a operator to unregister the macro character in a readtable.

Only SBCL. Sorry.

It is risky to modify the runtime readtable, so use at your own risk.


UNSET-MACRO-CHARACTER はリードテーブル中のマクロ文字登録を削除するためのオペレータです。

現状 SBCL でしかうごきません。

リードテーブルを変更するのはそれなりにリスクのあることです。

危険性を理解した上で、自己責任での使用でお願いします。



Requirement
-----------
* SBCL

Export
------
* Function: `unset-macro-character`
* Function: `unset-dispatch-macro-character`
* Function: `remove-dispatch-macro-charater`

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
      
#### `Function: remove-dispatch-macro-character disp-char (&optional *readtable*)`

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

UNSET-MACRO-CHARACTER の実装には `SET-SYNTAX-FROM-CHAR' を利用しています。


LICENSE
=======
MIT License.

-----

Copyright (C) 2011 Toshihisa Abe <<toshihisa.abe@gmail.com>>
