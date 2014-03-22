---
layout: post
pubdate: "2013-07-15T19:59:49+09:00"
title: Apache Archiva を試す
tags: [java]
pagetype: posts
---
Apache Archiva を試した。Apache Archiva はリポジトリ管理ソフトウェアで、Maven などのリポジトリを管理できる。やりたいこととしてはビルド済みの成果物についても共有の箇所で管理し、外部ライブラリとして再利用したい、ということだ。

詳細については SlideShare に『[Apache Archiva を試す][slideshare-apache-archiva]』としてスライドを公開したので、そちらを参照してほしい。

<iframe src="http://www.slideshare.net/slideshow/embed_code/24241180" width="427" height="356" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC;border-width:1px 1px 0;margin-bottom:5px" allowfullscreen webkitallowfullscreen mozallowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="http://www.slideshare.net/bouzuya/apache-archiva" title="Apache Archiva を試す" target="_blank">Apache Archiva を試す</a> </strong> from <strong><a href="http://www.slideshare.net/bouzuya" target="_blank">bouzuya</a></strong> </div>

使い勝手は正直なところ良いとは言えないが、インハウスリポジトリはたてようと思っていたので、ちょうど良いかな、と。Jenkins との連携やらで、また投げると思う。(IDE)Eclipse + (SCM)Git + (CI)Jenkins + (Repo)Archiva. の構成をつくりつつ、テスト駆動開発を試していきたい。8 月に入ったら Android を本格的にやる予定なので、そこで Java の知識がいきると良いんだけど。

また、本文とは関係ないが、スライドをもっと手軽に作成できるようにしたいと思い、Markdown からプレゼンテーション用の PDF を作成する方法についても調べた。そちらも SlideShare に『[Pandoc で Markdown から PDF へ変換][slideshare-pandoc-markdown-to-pdf]』として公開した。今回のスライド見ても分かるけど、まだ使いこなせていないので、作りながら良くしていきたい。

このスライド公開にあらわれているけれど、積極的に外に出ないといけなくなったので、露出を増やしていくつもり。情報の少なそうなものを試すときは特に。

15 min.

[slideshare-apache-archiva]: http://www.slideshare.net/bouzuya/apache-archiva
[slideshare-pandoc-markdown-to-pdf]: http://www.slideshare.net/bouzuya/pandoc-beamermarkdowntopdf

