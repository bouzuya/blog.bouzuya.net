---
layout: post
pubdate: "2013-11-16T16:06:04+09:00"
title: expressのbasicAuthミドルウェアを試す。
tags: [javascript]
pagetype: posts
---
expressのbasicAuthミドルウェアを試す。読む。しばらくexpress/connectのミドルウェアを読んで、試していく予定。

その前に簡単に前提知識を整理するために概要を書いておく。

まず、[express][npm/express]はNode.jsのWebアプリケーションフレームワークである。おそらくデファクトスタンダード。Rubyのsinatraにインスパイアされたもので、ルーティングとミドルウェアとを中心にしてシンプルな動きをするフレームワークである。

ルーティングはまあ置いておくとして、ミドルウェアとは何かを書く。ミドルウェアは要するにフィルタのようなもので、リクエストやレスポンスを通して何か変わるとそんな感じ。リクエストやレスポンスを各ミドルウェアが順に処理し、機能を提供する。例えば、BASIC認証であったり、gzip圧縮だったり、cookieのparseだったり、CSRF対策だったり、POSTのbodyのparseだったりする。前述のルーティングだって言ってしまえば、特定のパスへのアクセスを特定の関数にルーティングするという機能を持ったミドルウェアとも言える。

今日のbasicAuthもそのミドルウェアのひとつである。BASIC認証を提供するミドルウェア。

で、ちょっと話は脱線する。npmのページを見ると分かるのだけれど、expressは[connect][npm/connect]を使っており、ミドルウェアに関してはconnectのものをそのまま使えるようになっている。なので、「expressを知りたければconnectを読め」なんてのを見るくらいにconnectのミドルウェアを読むのは大切である。今回のbasicAuthもexpressがconnectのものを読みこんでいるだけである。expressのbasicAuthはconnectのbasicAuthである。expressをgrepしてもbasicAuthはない。connectのmiddlewareをすべて読み込んでいるだけだからだ。それが冒頭で「express/connect」と書いたわけ。

で、話を戻す。basicAuthの話に。basicAuthの[使い方はドキュメントにもある](http://expressjs.com/api.html#basicAuth)ので説明はそんなにしない。`app.use(express.basicAuth(user,pass));`の一行か、`app.use(express.basicAuth(function(user,pass) { return true; }));`か、あるいは`app.use(express.basicAuth(function(user,pass,fn) { return fn(null, 'user'); }));`。これで十分な気がする。[bouzuya/express-middleware-basicauth][bouzuya/express-middleware-basicauth]で試したものを残している。

内部動作としてはcallbackまたはuserpassを使って判定して、`req.user`のデータを見て、ああだこうだしている。ソース参照。複雑なことはしていない。

気になったのが、この間書いたexpress-resourceとの関係。auto-loadingを使うと`req.user`に値を入れられることがあって、大丈夫か不安だったのだけれど、簡単に試した感じだと問題はなさそう。basicAuthをルーティングより先に設定しておくべきなのは間違いない。

ええと、そもそもexpressでBASIC認証なんてしない気もするけれど、そこは気にしない方向で。

45 min.

[npm/express]: https://npmjs.org/package/express
[npm/connect]: https://npmjs.org/package/connect
[bouzuya/express-middleware-basicauth]: https://github.com/bouzuya/express-middleware-basicauth
