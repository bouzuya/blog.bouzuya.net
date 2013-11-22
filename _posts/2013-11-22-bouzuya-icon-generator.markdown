---
layout: post
pubdate: "2013-11-22T23:27:14+09:00"
title: bouzuya icon generatorを作った
tags: javascript
pagetype: posts
---
bouzuya icon generatorを作った。

アイコンを変えたくなった。前々から[@emanon001](https://twitter.com/emanon001)のアイコンと色使いが似ていて分かりにくいと言われていて。「全然違うじゃねえか」とか内心思いながらも、ゴレンジャイを思い出して、分かりやすくするのも良いかなと思ったからだ。

bouzuyaアイコンは、以前は手で作っていて、[Google Fonts](http://www.google.com/fonts) から得たフォントを使って`([:-P`を書いてgyazoで撮って、それをローカルに保存してuploadみたいな面倒な手順を踏んでいた。自分の顔だと言うのに、いいかげんなもので、ピタゴラスイッチのような不安定な工程を経て作られていた。

今回、色を変えるにあたり、もうすこし自動化することにした。Node.js+PhantomJSで。技術の無駄使いである。Node.jsでHTMLをホストして、それをPhantomJSで画像として保存する。これでリポジトリ管理下におけるし、再現性がある。安定したbouzuyaになる。

というわけで[bouzuya/bouzuya-icon-generator][bouzuya/bouzuya-icon-generator]として公開した。

別段、面白くもないもので。素朴なexpressと、PhantomJSのインストールのためのphantomjsと、Node.jsからPhantomJSを操作するためのnode-phantomの3つがメイン。asyncも定番?のライブラリなので、特に説明しない。最終的に生成されるのは静的なコンテンツなので、[bouzuya.net](http://bouzuya.net)にでもホストしておいて、それにアクセスするクライアントとして実装する方が簡単だと思うのだけれど、まあいいかな。

10 min.

[bouzuya/bouzuya-icon-generator]: https://github.com/bouzuya/bouzuya-icon-generator


