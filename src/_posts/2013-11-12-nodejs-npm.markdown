---
layout: post
pubdate: "2013-11-12T22:56:26+09:00"
title: npmは良いものだ
tags: [javascript]
pagetype: posts
---
現状のぼくのNode.jsのプロジェクトのはじめかたをメモしておく。あとで読み返したときに成長を感じるためだけのものなので、間違っても参考にはしないように。

まずは作業ディレクトリを作って`npm init`。`npm init`すれば`package.json`ができる。質問には適当に答える。どうせあとで直すので。

    $ mkdir project
    $ cd project
    $ npm init

次に`README.md`を作る。といってもプロジェクト名と概要を書くだけ。適当。

    $ cat >>README.md <<EOT
    > project
    > ==============================================================================
    > 
    > sample project.
    > EOT

次に`package.json`を修正する。ぼくはscriptに`"start": "node index"`と`"test": "mocha --reporter test"`にする。これで`npm test`でテストしたり`npm start`で起動させられてハッピー。

    $ vim package.json

次に`lib/`と`test/`を作成する。ついでにファイルを置く。ぼくはJavaScriptのソースコードとしては`index.js`だけをルートに置きたい。ほかは何かしらのディレクトリの下に入れたい。その方がすっきりして見える。

    $ mkdir lib/
    $ touch lib/server.js
    $ mkdir test/
    $ touch test/server.js
    $ cat >>index.js <<EOT
    > module.exports = require('./lib/server');
    > EOT

次に各種ライブラリ(開発向け)をインストールする。とりあえず`mocha`,`should`,`supertest`を使っている。`mocha`はテスティングフレームワーク。`should`はアサーション。`supertest`はアサーション付きのHTTPクライアント。`--save-dev`を付けておいて`devDependencies`として`package.json`に追記してもらう。npmは良い。

    $ npm install --save-dev mocha should supertest

次に各種ライブラリ(動作向け)をインストールする。とりあえず`express`,`async`を使っている。`express`はWebアプリケーションフレームワーク。Webアプリケーションでなければ`express`は要らないね。`async`はコールバックを書きやすくするためのライブラリ。まだ何とも言えないけど、`moment`や`mongodb`もよく使うものに入ってくるかも。お試し中。もちろん`--save`を付けておいて`dependencies`として追記してもらう。

    $ npm install --save express async

次に`.gitignore`を書く。`node_modules/`は要らないので無視する。

    $ cat >>.gitignore <<EOT
    > /node_modules
    > EOT

んで、git管理する。

    $ git init
    $ git add -A
    $ git commit -m 'initial commit'

ライブラリはもっといろいろ使ってる気がする。そらで書いたらこんな感じ。

23 min.

