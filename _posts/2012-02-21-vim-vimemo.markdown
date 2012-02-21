---
layout: post
pubdate: "2012-02-21T21:42:44+09:00"
title: ぼくの考えたメモ管理のためのVimプラグイン「vimemo」
tags: vim
---

Vimemoの概要
=====

[vimemo](https://github.com/bouzuya/vim-vimemo/)はメモを管理するためのVimプラグインである。

ぼくが晩ごはんを食べながら90分くらいで作成したプラグインだ。「90分もかけて100行のプログラムしか書けないなんて」と笑われることを承知で勇気を出してリリースした。

メモの記法を定義するつもりはない。MarkdownでもTextileでもhowmでも関係なく使えるようにしたい。ちなみにぼくはMarkdownで使うつもりだ。

メモ管理のためのツールを作るつもりだ。まだ他のツールとの比較はしていないが、なるだけシンプルで柔軟に対応できるものを作りたい。

Vimemoのインストール
=====

次のコマンドでvimemoをインストールできる。[NeoBundleで簡単かつ綺麗にインストールできる](http://vim-users.jp/2011/10/hack238/)ので、そちらでも良い。

    git clone git://github.com/bouzuya/vim-vimemo.git ~/.vim/bundle/vim-vimemo/
    echo set runtimepath+=~/.vim/bundle/vim-vimemo/ >> ~/.vimrc

Vimemoの機能
=====

いまのところ3つの機能がある。

1.\:VimemoOpen 新しいメモを開く
2.\:VimemoList メモの一覧を表示する
3.\:VimemoSearch メモから文字列を検索する

まだ機能が足りないので、これから足していく予定である。

最後に
=====

今後は使いながら機能改善していくつもりだ。ベータ版とREADMEに書いている。他のプラグインと比較しながら良いところは盗みたい。

ぼくのために作ったプラグインだけど、使ってみて感想を教えてもらえると嬉しい。使用感だけでなくVimスクリプトの添削も大歓迎である。

32 min.
