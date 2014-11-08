---
layout: post
pubdate: "2013-04-28T22:24:31+09:00"
title: Hatena::Graph API for Clojure 0.2.0
tags: [clojure]
minutes: 5
pagetype: posts
---
[Hatena::Graph API for Clojure 0.2.0][hatena-graph-0.2.0] を公開した。

変更は 2 点。

1 点目は、コマンドラインからデータを読んではてなグラフに送信できるようにした。使い方は README 参照で。

もう 1 点は認証情報を渡す箇所で `binding` を使わせるのではなく、`with-auth` というマクロを使うようにした。実装を隠した。

やりたかったことがあまりできてない。パズルを解くのに必死になっていたり。

5 min.

[hatena-graph-0.2.0]: https://github.com/bouzuya/clj-hatena-graph
