---
layout: post
pubdate: "2013-01-05T10:24:21+09:00"
title: "Clojure 向けのはてなグラフ API ラッパー『Hatena::Graph API for Clojure』を書いた"
tags: clojure
pagetype: posts
---
[Clojure][clojure] 向けのはてなグラフ API ラッパー『[Hatena::Graph API for Clojure][hatena-graph-api-for-clojure]』を書いた。

[はてなグラフ][hatena-graph]とは、[はてな][hatena]のサービスのひとつで、グラフを作ってくれるサービスである。1日1個の数を入れるだけで、あとはよしなにグラフを作ってくれるという気のきいたサービスだ。ライブラリーひとつで対応しました感はあるが、はてなのインフラにのっかれるのでお手軽である。しかし、はてなでもおそらく人気のないサービスで、トップページからのリンクがないのはその証拠である。

さて、はてなグラフには 『[はてなグラフ API][hatena-graph-api] 』がある。今回はそれを Clojure から呼び出すための薄いラッパーを書いた。

名前は『[Hatena::Graph API for Clojure][hatena-graph-api-for-clojure]』とした。

使いかたは [bouzuya/clj-hatena-graph][github-hatena-graph-api-for-clojure] を参照してほしい。簡単に書くと次のような感じ。

1. `project.clj` の `:dependencies` に `[org.clojars.bouzuya/hatena.graph "0.1.0"]` を加える
2. ソースファイルの先頭に `(use 'hatena.graph)` を加える
3. `(binding [*auto* {:username "x" :password "y"}] (post-data "graphname" "2012-01-01" "15"))` で認証しつつ、データを送る

分かりづらい方へのサンプルとテストも兼ねて、アプリケーションを書いた。[GitHub][github] の情報をはてなグラフに送る仕組みだ。全体の流れとしては次の通り。

1. 『[GitHub Counter(bouzuya/clj-github-counter)][github-github-counter]』…… GitHub の Following / Followers / Public Repos / Public Gists をカウントして CSV に書く
2. 『[GitHub -> Hatena::Graph(bouzuya/clj-github-to-hatena-graph)][github-github-to-hatena-graph]』…… GitHub Counter の出力データをはてなグラフに送る

GitHub -> Hatena::Graph がちょうど良いサンプルになると思う。

せっかくなので [Hatena::Graph API for Clojure][hatena-graph-api-for-clojure] 使ってみてほしい。

60 min.

[clojure]: http://clojure.org/
[hatena-graph-api-for-clojure]: https://clojars.org/org.clojars.bouzuya/hatena.graph
[hatena]: http://www.hatena.ne.jp/
[hatena-graph]: http://graph.hatena.ne.jp/
[hatena-graph-api]: http://developer.hatena.ne.jp/ja/documents/graph/apis/rest
[github]: https://github.com/
[github-hatena-graph-api-for-clojure]: https://github.com/bouzuya/clj-hatena-graph
[github-github-counter]: https://github.com/bouzuya/clj-github-counter
[github-github-to-hatena-graph]: https://github.com/bouzuya/clj-github-to-hatena-graph

