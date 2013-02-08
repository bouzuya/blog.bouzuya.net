---
layout: post
pubdate: "2013-02-08T23:24:51+09:00"
title: Leiningen の template を書いてみた
tags: clojure
pagetype: posts
---
Leiningen の template を書いてみた。[bouzuya/lein-template][lein-template] として公開した。

`lein new` は Leiningen 2.x より template を指定できる。`lein new template-name project-name` といった形である。せっかくなので、この機能を使って自分なりの template を書いてみた。

よく Clojure でライブラリを作ると Clojars で公開する。Clojars に置くと、Maven や Leiningen から取り込める。Leiningen なら `project.clj` に `[org.clojars.bouzuya/mylib "0.1.0"]` のように指定できるし、Maven なら `pom.xml` に指定できる。この指定のための記述を `README.md` にはいつも書きたい。あと、`doc/` は書いたことがないし、面倒なので書かない。

このような希望に合わせて書いた。

template のための template は template という名前である。`lein new template project-name` で作成できる。あとは default なんかを参考にしつつ作ると良い。

Maven リポジトリ (~/.m2) に登録されている `leiningen.new.xxx` を `lein new xxx ...` の形で呼べる。template にしたがって lein-template にした。

細かいことだろうけど、こういう部分を良くするのは楽しい。

21 min.

[lein-template]: https://github.com/bouzuya/lein-template

