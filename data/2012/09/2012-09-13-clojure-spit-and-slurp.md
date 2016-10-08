強引に定時で帰宅し、夢中でブログジェネレーターを作っている。楽しい。今日はpostのデータ構造の整理と、ファイル名を操作する箇所を作成した。拡張子の操作とかってJavaの標準機能でないのかな。もう自分で作ったのでどうでもいいのだけれど。

さて、せっかくClojureをさわっているので、覚えた関数を紹介してお茶をにごす。

今日はお手軽にファイルを読み書きする関数。`spit`と`slurp`。

<div><script src="https://gist.github.com/3714826.js?file=spit-and-slurp.clj"></script><noscript><pre><code>; ファイルの書き込み
(spit &quot;test.txt&quot; &quot;foobarbaz&quot;) ; =&gt; nil

; ファイルの読み込み
(slurp &quot;test.txt&quot;) ; =&gt; &quot;foobarbaz&quot;</code></pre></noscript></div>

`with-open`や`clojure.java.io/reader`や`clojure.java.io/writer`なんかを使うこともできるのだけれど、全体を一気に読むだけならこれで十分。お手軽すぎる。

15 min.
