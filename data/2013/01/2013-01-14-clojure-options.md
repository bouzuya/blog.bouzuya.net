---
layout: post
pubdate: "2013-01-14T23:24:54+09:00"
title: Clojure での省略可能引数の書きかた
tags: [clojure]
minutes: 12
pagetype: posts
---
Clojure での省略可能引数の書きかたについて考えてみた。

[Backlog API for Clojure][backlog-api-for-clojure] を書いているときに気づいたことなのだけれど、ぼくは省略可能引数の書きかたが定まっていない。そこで今日はそれをひとつに決めるべく、試行錯誤してみた。

結果はすべて [Gist][gist] に書いた。

目標は、省略可能引数の検証と取り出しを簡潔にすること。例えば `(f :a \a :b \b :c \c)` のような呼び出しをしたとすると、`:a` `:b` `:c` が指定可能な引数なのかを検証し、`{:a \a :b \b :c \c}` という Map を取り出したい。欲を言えば、既定値を指定したい。`:b` を省略すれば `\1` に、`:c` を省略すればなしに。そういう既定値を指定したい。

今回は、指定不可能な引数が指定されると無視され、値が `nil` のものは削除されるようにした。ひとまず、この関数を使ってみようと思う。

12 min.

[backlog-api-for-clojure]: https://github.com/bouzuya/clj-backlog
[gist]: https://gist.github.com/4529917
