---
layout: post
pubdate: "2013-01-15T23:47:17+09:00"
title: Kuromoji で読みを使う
tags: clojure, kuromoji
pagetype: posts
---
[bouzuya/clj-kuromoji-example](https://github.com/bouzuya/clj-kuromoji-example/tree/0.3.0) `0.3.0` を公開した。

今回は [Kuromoji][kuromoji] で読みを得てみた。`Token` クラスの `getReading` メソッドを使えば、漢字の読みを得られる。カタカナの場合には読みが得られず `nil` が返されるので、その場合は `getSurfaceForm` メソッドで元の文字列を返すようにした。

[ソースコードはここから参照](https://github.com/bouzuya/clj-kuromoji-example/blob/0.3.0/src/kuromoji_example/reading.clj)。

[テストコードはここから参照](https://github.com/bouzuya/clj-kuromoji-example/blob/0.3.0/test/kuromoji_example/reading_test.clj)。

これで文章の読みを得られている、はず。明日はこれを使って遊ぶ。いやあ簡単だ。こういうライブラリを作ってくださると助かる。

8 min.

[kuromoji]: http://www.atilika.com/products/kuromoji.html



