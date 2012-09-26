---
layout: post
pubdate: "2012-09-26T22:12:10+09:00"
title: JScriptでglobalなevalできない
tags: jscript
pagetype: posts
---
わけあってサクラエディタのマクロを書いている。

困ったことにサクラエディタのマクロはWSFが使えないので、複数ファイルに分割できない。仕方なくFileSystemObjectでファイルを読んでevalしようとしたのだけれど、evalで定義した関数が外のスコープから見えない。一番外側のスコープで`var global = this;`して`eval.call(global, s)`してみたり、`("global",eval)(s)`してみたり、色々試したんだけどうまくいかない。

諦めて重複コードを書くことにする。

7 min.
