---
layout: post
pubdate: "2013-03-23T23:51:24+09:00"
title: oikura の properties 読み込み対応
tags: [clojure]
minutes: 5
pagetype: posts
---
Tomcat へのデプロイのため oikura に地味な修正をした。

1. 環境変数で設定していた構成情報を properties ファイルで設定するようにした
2. Servlet Context の情報を埋め込むようにした

これらの対応で `http://example.com/oikura/` としてデプロイしても期待どおりに動作するようになった。機能が増えていないとパッとしないんだよね。こういう対応も必要なのだろうけど、あくまで良くするために必要なものだけにしないとまずいね。

5 min.
