---
layout: post
pubdate: "2012-09-02T23:25:55+09:00"
title: misakiのcompilerを作る
tags: misaki,clojure
pagetype: posts
---
そろそろ[misaki](http://liquidz.github.com/misaki/)のcompilerを作ろうと思い、動きを調べた。

[Switch compiler](http://liquidz.github.com/misaki/toc/06-switch-compiler.html)の手順に従い、`samples/blog/_config.clj`のcompilerを`demo`に設定した。demoは.txtを見て、先頭に"Hello, "を付与するcompilerである。最初`samples/blog/*`には.txtがないため、動きがちっとも分からなかった。それというのも、misakiのcompilerは現状ひとつしか指定できず、-extensionが返す拡張子しか処理できないからだ。

それを確認するためにtestという名前のcompilerを作ることにした。testはdemoのcompilerをもとにしたcompilerで、demoとdefaultをあわせた動きをする。具体的には.txtはdemoが処理し、.cljはdefaultが処理する形だ。-extensionは`misaki.compiler.default.core/-extension`の戻り値と:txtをあわせたものを使い、-compileでは条件分岐させて、それぞれが処理する。

@uochanに確認したところ、どうもこういう動きを想定していなかったらしく、今後複数コンパイラー指定に対応してくれるとのこと。期待して待つつもり。

10 min.
