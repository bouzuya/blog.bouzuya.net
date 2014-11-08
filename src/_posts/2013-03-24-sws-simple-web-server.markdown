---
layout: post
pubdate: "2013-03-24T21:45:31+09:00"
title: sws シンプルな Web サーバーを作った
tags: [clojure]
minutes: 7
pagetype: posts
---
oikura のテンプレートとして使う HTML を作る際に、ファイルをダブルクリックして `file://` で確認していたのだけれど、`/style/default.css` など URL の絶対パスが正しく解釈されなくて困るので、シンプルな Web サーバーを作ることにした。

幸い、作るための部品はすべて揃っている。[Ring][ring] の Jetty アダプターにある `run-jetty` を使えば簡単に Jetty を起動できるし、ファイルへそのままルーティングするのも [Compojure][compojure] の `files` を使えば良い。

というわけでできたのが今回の [bouzuya/sws][bouzuya/sws] 。ほんの数行のコードだけど、期待どおり動くので満足している。肝心のテンプレート作成は気付いたら寝てしまっていて動きを作れていないけど……。

7 min.

[bouzuya/sws]: https://github.com/bouzuya/sws
[ring]: https://github.com/ring-clojure/ring
[compojure]: https://github.com/weavejester/compojure
