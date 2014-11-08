---
layout: post
pubdate: "2012-09-08T19:28:17+09:00"
title: misakiのcompiler作ったった(CoffeeScript編)
tags: [misaki, clojure, coffee-script]
minutes: 20
pagetype: posts
---
[以前、日記で紹介したmisakiのLESS CSS Compiler](http://bouzuya.github.com/2012/09/04/misaki-compiler-3.html)を基に[liquidz/misaki](https://github.com/liquidz/misaki)のCoffeeScript Compilerを作った。

[GitHub](https://github.com/)にて[bouzuya/misaki-coffee-script](https://github.com/bouzuya/misaki-coffee-script)として公開している。

動きの大枠はLESS CSS Compilerとまったく同じである。対象となる拡張子が`.coffee`であり、configが`coffee-script-in-dir`と`coffee-script-out-dir`になり、核となるcompiler部分を[rbolkey/clj-coffee-script](https://github.com/rbolkey/clj-coffee-script)に変えてあるくらいである。

`template/coffee/main.js.coffee`が`public/js/main.js`になるように設定している。

misaki-coffee-scriptも核の部分は他の方が作ったものにおまかせなので、misakiのインタフェースを合わせているに過ぎない。さすがに、これくらいならぼくでもできると思っている。

今日は、この他に[自分のためのmisakiのディレクトリ構成](https://gist.github.com/3671177)をGistに書いてみた。このイメージ図にCoffeeScriptを書いてしまったので、作っただけで、実を言うとCoffeeScriptをろくに書いたことがない。直近のWEB+DB Pressに入門記事があったので調子に乗ってみただけである。

20 min.
