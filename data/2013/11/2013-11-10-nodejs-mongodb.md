Node.jsからMongoDBを使う。使うための写経などをしている。とりあえず[ドットインストールのMongoDB入門][dotinstall-mongodb]を観た。ざっくりと理解した。

実際にMongoDBをインストールする。`apt-get install mongodb`で。

CLIから操作してみる。`mongo`でコンソールを開いて、適宜JavaScriptのコマンドを実行する。データベースやコレクションやドキュメントを作ってみる。ドットインストールの内容を確認する。

次にコードに組み込んでみる。Node.jsの自分のコードに組み込む。怪しい動きをする。切り分けが難しくなってしまったので、検証用のコードを書いた。[bouzuya/node-mongodb-example][bouzuya/node-mongodb-example]。

そして再度組み込む。美しさはともかくとして、とりあえず動いた。[bouzuya/msg][bouzuya/msg]の0.1.0としてリリースしてみた。userのCRUD。UPDATEは使わないのでCRD。

脱線しすぎて[git-flow][git-flow]の検証を兼ねていることをすっかり忘れていた。git-flowでブランチモデルをひとつ勉強してみようと思っている。誰かがある程度完成させたブランチモデルを試してみて、良いところを採用しようという方針。ブランチモデルだけでなくツールもあるなら、期待できるだろう。

14 min.

[dotinstall-mongodb]: http://dotinstall.com/lessons/basic_mongodb
[bouzuya/node-mongodb-example]: https://github.com/bouzuya/node-mongodb-example
[bouzuya/msg]: https://github.com/bouzuya/msg/tree/99ec2db8b431a69fe4f4444506ee4c2ca936cbd3
[git-flow]: https://github.com/nvie/gitflow
