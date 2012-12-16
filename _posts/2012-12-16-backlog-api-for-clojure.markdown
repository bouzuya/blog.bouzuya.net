---
layout: post
pubdate: "2012-12-16T23:06:31+09:00"
title: Backlog API for Clojure を公開した
tags: clojure
pagetype: posts
---
[昨日書いたBacklogというサービス](/2012/12/15/backlog)だけれど、 [API を公開](http://www.backlog.jp/api/)していて、外部のアプリケーションから操作できるようになっている。API は XML-RPC で提供されており、https + BASIC認証で接続するようになっている。

友人からの頼みで Clojure で、外部からコメントを投稿するアプリケーションを作った。GitHub に『[bouzuya/clj-backlog](https://github.com/bouzuya/clj-backlog/)』として公開した。

Clojure 向けの XML-RPC 用のライブラリとして、[brehaut/necessary-evil](https://github.com/brehaut/necessary-evil/)を使った。お手軽に実装できて良い。

BASIC 認証部分でややハマったが、`call*`という関数を使うことで、necessary-evil 内部で使われている[dakrone/clj-http](https://github.com/dakrone/clj-http/)に引数を指定できることが分かり、対応できた。次のように指定する。

    (call* url methodname args :request {:basic-auth [username password]})

もうすこし作りこんで、Clojure 向けの汎用 Backlog API にしたいと考えている。できあがったら [Backlog アプリケーション](http://www.backlog.jp/api/application/)に申請してみようかな。

余談だけれど、GitHub に用意されていた Backlog との連携用のフックを使って、課題の自動クローズも試した。思った以上にうまく機能する。チケットと Git との連携は必須だなあ。Backlog から TiDD デビューしようかしら。

23 min.
