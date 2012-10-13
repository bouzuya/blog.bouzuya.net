---
layout: post
pubdate: "2012-10-13T22:20:32+09:00"
title: misakiのコンパイラーの設定方法
tags: clojure, misaki
pagetype: posts
---
[liquidz/misaki](https://github.com/liquidz/misaki)に複数コンパイラー対応機能が搭載される。まだmisakiのmasterにはmergeされていないけど、きっと数日のうちに対応されるだろう。

実は2週間ほど前から機能はできていて、作者の[@uochan](https://twitter.com/uochan)に確認を依頼されていたにもかかわらず、忙しさにかまけて放置してしまっていた。昨日あたりせっつかれてしまい、謝りながら今日確認した次第だ。

確認ついでに、ぼくのLESSCSSコンパイラー[bouzuya/misaki-lesscss](https://github.com/bouzuya/misaki-lesscss)とCoffeeScriptコンパイラー[bouzuya/misaki-coffee-script](https://github.com/bouzuya/misaki-coffee-script)も更新した。本家の変更に対応しただけなので、機能追加などはない。

READMEに設定方法などを書いていないので、暫定ではあるが自分なりの「コンパイラー追加方法」を書いておく。

1. misakiを`git clone`する
2. `project.clj`の`:dependencies`にcompiler jarを追加する
   例) `:dependencies [ ... [org.clojars.bouzuya/misaki-lesscss "0.1.2"]]`
3. `_config.clj`の`:compiler`にcompiler nameを追加する
   例) `:compiler ["lesscss" "default"]`
4. いつもどおりに`lein run`

今回はmisaki-lesscssとmisaki-coffee-scriptを[Clojars.org](https://clojars.org/)に暫定ではあるけれど、ぼくのユーザー名で登録しておいたので、上記のように手軽にmisakiのコンパイラーを試すことができる。

- [clojars.org(misaki-lesscss)](https://clojars.org/org.clojars.bouzuya/misaki-lesscss)
- [clojars.org(misaki-coffee-script)](https://clojars.org/org.clojars.bouzuya/misaki-coffee-script)

興味があればぜひ試してほしい。

20 min.
