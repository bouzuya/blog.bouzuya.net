---
layout: post
pubdate: "2013-11-18T23:59:59+09:00"
title: express/connectミドルウェアbodyParserを読む
tags: [javascript]
pagetype: posts
---
[express][npm/express]/[connect][npm/connect]のミドルウェアを読んでいく。今回はbodyParserミドルウェアを読んでいく。

その前に前回の補足。expressがconnectのミドルウェアを読みこんでいるとだけ説明していたので、ソースを示しておく。以下のリンクがそれ。

[https://github.com/visionmedia/express/blob/master/lib/express.js#L41](https://github.com/visionmedia/express/blob/master/lib/express.js#L41)

んで、前回書きそびれたけれど、今回はexpressに3.4.4を使用している。詳細は`package.json`を見れば良い。

### bodyParserミドルウェア

で、bodyParserミドルウェアについて。

bodyParserミドルウェアはHTTPのリクエストボディをparseするためのもの。

次のものは同等。

    app.use(express.bodyParser());

    app.use(express.json());
    app.use(express.urlencoded());
    app.use(express.multipart());

またconnectの3.0からはmultipartミドルウェアが削除されるため、現在はbodyParserミドルウェアの使用時にwarningが出力される。

    connect.multipart() will be removed in connect 3.0
    visit https://github.com/senchalabs/connect/wiki/Connect-3.0 for alternatives

express@3.4.4はconnect@2.11.0に依存しているのでwarningをただ無視するでも良いのだけれど、warningを消したいならbodyParserを使うのではなく、次のようにすれば良い。ただし、動作が違うので注意。

    app.use(express.json());
    app.use(express.urlencoded());

connectの2.xと同じ動きをするための方法や、それぞれのミドルウェアの働きについては後述する。

### jsonミドルウェア

まずはjsonミドルウェアから。

jsonミドルウェアはHTTPのリクエストボディのうちjsonをparseするもの。

- bodyがまだparseされていない(`req._body`が設定されていない)か。
- HTTPのリクエストヘッダにtransfer-encodingが含まれているかcontent-lengthが含まれていて流さが0でないか。
- HTTPのリクエストヘッダのcontent-typeがapplication/jsonにマッチするか(厳密な正規表現は`express.json.regexp`を参照)。

で判断した上で、`JSON.parse`でparseする。結果は`req.body`に格納される。

オプションとして次のものを指定できる。

- strict:trueにすると`{`や`[`からはじまらないjsonは400エラーを返す。
- reviver:`JSON.parse`の第2引数に使われる。valueの変換関数。iso8601形式を避けるのに使われる?
- limit:デフォルトで1MiB。サイズの上限を設定する。
- verify:parse前に独自の検証を追加する。`function(req, res, buf)`で指定し、検証でエラーになればErrorをthrowする。エラーに`status`を持たせるとそれがHTTPのレスポンスのステータスコードになる。

### urlencodedミドルウェア

次はurlencodedミドルウェア。

urlencodedミドルウェアはHTTPのリクエストボディのうちformから送信されるデータ(application/x-www-urlencoded)をparseするもの。

- bodyがまだparseされていない(`req._body`が設定されていない)か。
- HTTPのリクエストヘッダのcontent-typeがapplication/x-www-urlencodedか。

で判断した上で、[qs][npm/qs]の`qs.parse`でparseする。結果は`req.body`に格納される。

オプションは`limit`と`verify`とがあるけれど、jsonミドルウェアと同じなので、触れる必要もないかな。

### multipartミドルウェア

最後がmultipartミドルウェア。これはmultipart/form-dataをparseするもの。

要するにアップロードされたファイルを処理するのだけれど、これがちょっとまずいみたい。なぜこれがbodyParserから外されているかはwarningとして表示されるurlを見れば分かるのだけれど、セキュリティ上の問題と`defer`オプションが複雑なことが問題みたい。セキュリティ上の問題が何を指すのか分からないけど、おそらく`os.tmpDir`に一時ファイルを作成するが自動削除されないようになっている動きのことだと思う。アップロードを続ければサーバーをクラッシュさせられる、と。たぶん。`defer`オプションはstreamとしてファイルを扱いたい場合に有効にするもの。有効にしておいて、あとはイベントを処理するらしい。検証はしていない。

もし、multipart/form-dataこれを使う場合は開発者が直接に次の他のミドルウェアを使うべきらしい。

- formidable
- connect-multiparty or multiparty
- connect-busboy or busboy

ふむ。multipartミドルウェア関連はまた今度にしよう。

60 min.

[npm/qs]: https://npmjs.org/package/qs
[npm/express]: https://npmjs.org/package/express
[npm/connect]: https://npmjs.org/package/connect

