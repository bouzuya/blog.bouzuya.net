---
layout: post
pubdate: "2013-01-27T23:59:59+09:00"
title: clojure.data.zip.xml を試す
tags: clojure
pagetype: posts
---
`clojure.data.zip.xml` を使って Clojure で XML を扱った。

もともと XML を扱うことを目的としていたわけではなくて、Google Reader API を呼び出した際に返ってくる Atom Feed ( XML ) を読むために、ついでに調べただけ。やってみると簡単は簡単なのだけれど、その方法にたどりつくまでに時間がかかったので、忘れないようにメモしておこう、というわけ。

コードは Gist に貼りつけた。解説もそこにコメントとして書いたので、そちらをどうぞ。

[https://gist.github.com/4648350](https://gist.github.com/4648350)

`clojure.data.zip.xml` は XML zipper を補助するための関数を提供している。`xml->` という関数が便利なのだけれど、これは [enlive](https://github.com/cgrand/enlive) のセレクターをシンプルにしたような動きをする。セレクターと呼ぶには弱い気はするけれど、何もないよりずっと楽に XML を走査できる。

また機会があれば試してほしい。

14 min.
