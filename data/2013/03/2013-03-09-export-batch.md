---
layout: post
pubdate: "2013-03-09T23:59:59+09:00"
title: Subversion からエクスポートして
tags: [java]
minutes: 5
pagetype: posts
---
Java で Subversion から .java ファイルをエクスポートして、エクスポートディレクトリにある .java ファイルに対応する .class ファイルを、既にコンパイルの終わっている別のディレクトリからコピーしてくるバッチ処理をするコードを書いた。[bouzuya/ExportBatch][bouzuya/ExportBatch] に公開している。

いやに具体的な上にそもそもそんな処理必要になる状況はおかしいだろといいたくなるけど、そこは気にしてはいけない。常識が通じないことはよくある。

一直線なコードになってしまったけど、SVNKit を使って Subversion を操作していたり、Apache Ivy を使っていたりと、新しいことを試していたりもする。うん。

5 min.

[bouzuya/ExportBatch]: https://github.com/bouzuya/ExportBatch
