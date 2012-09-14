---
layout: post
pubdate: "2012-09-14T23:38:39+09:00"
title: Clojureでコードを書いている
tags: clojure
pagetype: posts
---
Clojureでenliveを使った静的サイトジェネレーターを作っている。misakiには組み込めればと思っているが、無理なら諦める。今日はfileまわりのユーティリティにテストコードをつけて、別ファイルに切り出すなどリファクタリングした。もうしばらく出せないので、今日もTipsでお茶をにごす。

さて、今日は表明(assertion)機能について。Clojureの関数は事前条件/事後条件を設定しておくことができる。方法としてはそれぞれ:preおよび:postをメタデータに付与しておく。下記コードを参照してほしい。

<div><script src="https://gist.github.com/3722379.js?file=assert.clj"></script><noscript><pre><code>(defn str-to-int
  [s]
  {:pre [(string? s)]
   :post [(number? %)]}
  (Integer/parseInt s))

(str-to-int 10) ; java.lang.AssertionError
(str-to-int &quot;10&quot;) ; =&gt; 10</code></pre></noscript></div>

すごく無意味なコードだけど、伝えたいのは:pre :postの部分だ。

事前条件として引数が文字列であることを確認し、事後条件として戻り値が数値であることを確認している。事後条件の`%`には戻り値が入る。

条件を満たさない場合は、java.lang.AssertionErrorが投げられる。Javaの`assert`を使うようなイメージだろう。入力チェックとして使うものではなく、あくまで前提条件を表明しておくものである。うまく使えば安心感を得ながらコーディングができると思う。

こんなとこでいいですかね。

20 min.
