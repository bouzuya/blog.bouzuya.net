ClojureでEnliveを用いたスクレイピングを試した。ソースコードは[bouzuya/clj-eklib](https://github.com/bouzuya/clj-eklib)を参照すること。現状では実用的な例ではなく、何ができるのかを確認するための例である。

動作としては次のようになる。[clj-http](https://github.com/dakrone/clj-http)を用いてWebサイトからHTMLをダウンロードしてEnliveに食わせる。あとはEnliveのセレクタを活かして、ほしい情報を取り出す。Enliveはテンプレートエンジンであると同時に優秀なセレクタを持つHTMLパーサーであることを活かしている。

Amazonのトップページから「サインイン」リンクをたどり、input要素を取得してPOSTしている。いい加減な実装ではあるが、きちんとログインできる。

コードはさほど綺麗なものではないが、比較的簡単に実現できた。次回はもうすこし複雑な動作を試したいと思う。

20 min.
