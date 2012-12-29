---
layout: post
pubdate: "2012-12-29T17:07:11+09:00"
title: Backlog API for Clojure の使いかた
tags: backlog, clojure
pagetype: posts
---
[Backlog API for Clojure](https://github.com/bouzuya/clj-backlog) を [Backlog アプリケーション](http://www.backlog.jp/api/application/) に掲載していただけるそうなので、使いかたなどを書いておく。

## Backlog API for Clojure とは

[Backlog API for Clojure](https://github.com/bouzuya/clj-backlog) は [Clojure](http://clojure.org) から [Backlog API](http://www.backlog.jp/api/) へのアクセスをやさしくするためのライブラリである。

ソースコードは [GitHub](https://github.com/) の [bouzuya/clj-backlog](https://github.com/bouzuya/clj-backlog) にあり、jar ファイルは [Clojars](https://clojars.org) の [org.clojars.bouzuya/backlog](https://clojars.org/org.clojars.bouzuya/backlog) にある。

## 使いかた

Clojars にあるので [Leiningen](https://github.com/technomancy/leiningen) を使っているのなら `project.clj` の `:dependencies` に `[org.clojars.ouzuya/clj-backlog "0.3.0"]` を足して、`lein deps` で良い。

関数などの名前は `backlog.getProject` なら `backlog/get-project` 、`backlog.admin.getUsers` なら `backlog.admin/get-users` のように、Clojureでよく使われるハイフン区切りに置き換えている。

次のようにして呼び出せる。

    (require 'backlog '[backlog.config :as config])
    (binding [config/*backlog-auth* {:spacename "space" :username "user" :password "xxxx"}]
      (backlog/get-project "PROJ"))

`backlog.*` や `backlog.admin.*` の呼び出し前には `backlog.config/*backlog-auth*` にログイン情報を忘れず設定すること。

引数の指定は、必須のものはドキュメントの順に指定し、省略可能のものはキーワードと値を並べて書く。キーワードの名前もまた関数と同じように `user_id` なら `user-id` 、`projectId` なら `project-id` と置き換えている。API リファレンスに書かれている `PascalCase` や `camelCase` や `snake_case` などは `clojure-style` に置き換えて読むと良い。

    ; プロジェクト "PROJ" から未対応の課題を得る(認証は割愛)
    (let [project-id ((backlog/get-project "PROJ") :id)]
      (backlog/find-issue project-id :status-id 1))

`:status-id` は省略可能な引数である。

上記例から分かるとおり、戻り値は XML ではなく Clojure のオブジェクトで返される。詳細は [brehaut/necessary-evilの xml-rpc mappings](https://github.com/brehaut/necessary-evil/#xml-rpc-mappings) を参照してほしい。

戻り値のキーワードについても関数や引数と同じような置き換えを取り入れるつもりだが、まだ実装できていない。今後もマイナーバージョン間でさえ互換性はないと考えてほしい。特定バージョンを使用するだろうし、問題ないと考えている。

## サンプルアプリケーション

サンプルアプリケーションとして、コメントを投稿する [bouzuya/clj-backlog-commenter](https://github.com/bouzuya/clj-backlog-commenter)  を作成した。

Backlog API for Clojure 利用の際には、これらも参考になるかもしれない。

## さいごに

Backlog API for Clojure で、Clojurian の Backlog ライフがより充実することを願っている。

60 min.

