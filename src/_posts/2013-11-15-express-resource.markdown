---
layout: post
pubdate: "2013-11-15T23:31:06+09:00"
title: express-resourceを試す
tags: [javascript]
pagetype: posts
---
express-resourceを試す。そのメモ。

- Node.jsではデファクトスタンダードなWebアプリケーションフレームワークexpressを拡張するライブラリ。
- expressにresource構文を提供するexpress-resourceを試す。
- 詳細は[https://npmjs.org/package/express-resource](https://npmjs.org/package/express-resource)からたどるか、
- GitHubの[https://github.com/visionmedia/express-resource](https://github.com/visionmedia/express-resource)からどうぞ。
- resourceはRuby on Railsのconfig/routes.rbでおなじみの構文で、特定のリソースに対するCRUDを提供する。
- express-resource が定義する routes は次の通り。

    GET     /                 ->  index
    GET     /new              ->  new
    POST    /                 ->  create
    GET     /:id              ->  show
    GET     /:id/edit         ->  edit
    PUT     /:id              ->  update
    DELETE  /:id              ->  destroy

- `app.get`や`app.post`でいくつも定義していたものを`app.resouce`でまとめて定義してくれる。
- さっそく試す。試した結果は[bouzuya/express-resource-example](https://github.com/bouzuya/express-resource-example)にある。

- `npm install express-resource`などでインストールする。
  - npmの使い方は過去記事を参照。ぼくは`--save`をつけて`package.json`にも書いてもらう。
- 基本は`app.resource(path, actions)`
- optionsを指定できる`app.resource(path, actions, options)`
  - id optionは`:id`を変更できる。
    - `app.resource('users', actions, { id: 'user_id' })`とすれば、通常`/users/:user`となるところを`/users/:user_id`とできる。
    - ただし、後述するAuto-Loadingが不自然になるのでおすすめしない。
  - load optionはAuto-Loading機能で、express-resourceの特徴的な機能。
    - loaderとして動作する関数を設定しておくと、`req`に`:id`名でloadした値が設定される。
    - `app.resource('users', actions, { load: (function(id, fn) { fn(null, users[id]); }) })`とすれば、`users[id]`を`req.user`で取得できる。
      - `/users/:user`なので`req.user`になる`/users/:user_id`にしていると`req.user_id` になる。
- content-negotiationはその名前の通りコンテンツを拡張子で判別して最適なものを返すための仕組み。
  - 具体的には`req.format`で指定された拡張子を取得できる。
  - `/users/1.json`なら`req.format`で`'json'`を取得できる。

個人的にはauto-loadingはどうかなあと思ってしまう。idを指定しているところをそのまま変数名に使うのもアレだし、routesで割り振った先でloadする方がつくりとして自然になる気がする。

その他はごくごく普通の動きをしているので、素直に使える。Ruby on Railsで言うところの`:only`などはないが、関数を定義していなければroutingされないので、気にしなくて良い。Ruby on Railsのとりあえず作る動きよりはずっと自然に感じる。expressを使うなら常用しても良いかも。

ちなみにドキュメントは大して用意されていないが、テストコードは綺麗で分かりやすいのでおすすめ。上記GitHubのリンクからたどると良い。

60 min.
