---
layout: post
pubdate: "2012-09-12T23:39:40+09:00"
title: enliveでサイトを作っている
tags: [enlive, clojure]
minutes: 12
pagetype: posts
---
定時で帰れたのでenliveでサイトを作っている。

昼休みと通勤電車でenliveのソースコードはおおよそ読んだ。ただ読むだけだとちっとも頭に入らないので、使おうとしている。

例の[オレオレmisakiのディレクトリ](https://gist.github.com/3671177)の構成に合わせて作っている。`_layout/post.html`と`_layout/default.html`をテンプレートとして、`_post/*.markdown`と`_post/*.clj`から記事データを生成して、`_public/*.html`として出力することはできた。

でも、これをその他ページでも使えるように汎用的にするのは難しそうだし、enliveのできることを削るだけになってしまうのだけれど、どうなんだろう……。snippetをincludeしたり、親レイアウトを指定して、そこにデータを埋め込んだり。そういうことをmarkdownだけである程度できるようにすることに何か意味があるのだろうか。

そもそもenliveはテンプレートとそれを操作するロジックとを完全に分離することが魅力なのに、どうなんだろう。とりあえずサイトは作ってみるよ。出来上がったらそれを元にmisakiに、ってあれ、生成できるならmisaki要らないんじゃ……。

12 min.
