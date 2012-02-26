---
layout: post
pubdate: "2012-02-26T21:00:39+09:00"
title: .vimrcの行数をはてなグラフに表示する
tags: vim
---
先日[.vimrcを1000行にする](http://bouzuya.github.com/2012/02/23/vimrc.html)と書いた。せっかくなので行数の推移を可視化することにした。

仕組みとしては次のようになる。
1.wcコマンドで.vimrcの行数を数える。
2.日付と行数をCSVファイルに追記する。
3.CSVファイルをはてなグラフにPOSTする。

はてなブログに自動でPOSTするようにしたときと同じ動きなので1時間ほどでできた。できあがりは次のような感じ。トップページからも見ることができる。さあ後は1000行目指してがんばるのみ!

<img src="http://graph.hatena.ne.jp/bouzuya/graph?graphname=.vimrc" width="130" height="90" alt="bouzuyaの.vimrc" />

11 min.
