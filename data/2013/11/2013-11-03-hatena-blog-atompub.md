---
layout: post
pubdate: "2013-11-03T23:59:59+09:00"
title: はてなブログ AtomPub を使ってみた
tags: [ruby]
minutes: 30
pagetype: posts
---
はてなブログ AtomPub を使ってみた。Ruby のサンプルコードに従い動かしてみたところ、動かない。

stacktrace を見ていくと atomutil gem は https に対応していないみたい。簡単に対応できそうだったので、[lyokato/ruby-atomutil][lyokato/ruby-atomutil] を fork して [pull request][lyokato/ruby-atomutil/pull/1] した。merge された。gem として更新されるかは分からないので、とりあえず以下のように記述して対応。

<script src="https://gist.github.com/bouzuya/7291697.js"></script>

はてなはエンドポイントを https にしたなら、サンプルコードも URL の書き換えだけでなく、きちんと動くか見てほしいものだ。

で、軽くはてなブログ AtomPub を使ってみる。

<script src="https://gist.github.com/bouzuya/7292111.js"></script>

うん。エントリができる。

ここ数日分のエントリがうまく同期されていないので、適当に直しておかないとなあ。

明日はたぶん 10 月の振り返りをする。ひどいなあ。見たくないなあ。

30 min.

[lyokato/ruby-atomutil]: https://github.com/lyokato/ruby-atomutil
[lyokato/ruby-atomutil/pull/1]: https://github.com/lyokato/ruby-atomutil/pull/1

