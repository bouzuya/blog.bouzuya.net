---
layout: post
pubdate: "2013-02-10T22:26:54+09:00"
title: Ubuntu 12.10 のインストール
tags: [misc]
minutes: 25
pagetype: posts
---
Ubuntu を PC にインストールしたくなった。いままでは VirtualBox でゲスト OS として使ってきたが、気が変わったので、インストールすることにした。

Ubuntu Desktop 12.10 32 bit を Lenovo G570 にインストールする。

[ubuntu.com][ubuntu-desktop-download-url] から OS イメージをダウンロードする。いつもなら VirtualBox なので OS イメージのままで良いが、今回は物理的にドライブに入れるため DVD に書きこむ。700 MB+ なので、 CD でも大丈夫かと思ったが無理だった。諦めて DVD に。

Lenovo G570 には Windows 7 がインストールされており、既に使っていたのでデータを退避した。デュアルブートなどもできないことはないが、ぼくは素直にインストールされた Ubuntu を使ってみたいので、今回は消してしまう。そんなに高価なマシンでもないし、惜しくはない。

データ退避の過程で学んだこと。VirtualBox からゲスト OS を退避するときは、仮想アプライアンスのエクスポートとインポートで簡単にバックアップできる。

さて、ひとまず Live CD としてインストールせず DVD から動きを確かめる。DVD を挿入して起動後に Try Ubuntu と書いてあるボタンで動かす。一通り動きを見て、トラックボールや Web カメラも動くこと確かめた。

Desktop に表示された「 Ubuntu 12.10 をインストールする」のショートカットを開くと、パーティションの選択などがされる。今回は Windows 7 の入ったディスクを消し、Ubuntu をインストールした。

起動後ネットワークがうまくつながらないトラブルがあったが、再起動で直ったので良しとする。しばらくはこの環境で様子を見るつもりだ。

25 min.

[ubuntu-desktop-download-url]: http://www.ubuntu.com/download/desktop

