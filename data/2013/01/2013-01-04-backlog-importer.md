[Backlog Importer][backlog-importer] を書いた。

Backlog Importer は [Backlog][backlog] に課題を CSV ファイルから一括で取り込むためのコマンドラインユーティリティである。セットアップや区切りなどにたくさんの類似の課題を登録したい場面はあると思うが、Backlog は取り込み機能を標準で持っていないため、作ることにした。

動作は Java さえあれば可能である。ただし、ビルドに Clojure / Leiningen が必要であり、ビルド済みのファイルは配布していない。ソースコードは [GitHub][github] の [bouzuya/clj-backlog-importer][backlog-importer] で公開している。

Backlog Importer は [Clojure][clojure] で書いており、[Backlog API for Clojure][backlog-api-for-clojure] を使っている。実際のところ Backlog API for Clojure のサンプルアプリケーションとして書いた。

使いかたは [usage][backlog-importer-usage] を見てほしい。簡単に説明すると CSV ファイルを所定のレイアウトで作成し JAR ファイルを実行するだけだ。

45 min.

[backlog-importer]: https://github.com/bouzuya/clj-backlog-importer
[backlog-api-for-clojure]: https://github.com/bouzuya/clj-backlog
[backlog]: http://www.backlog.jp/
[github]: https://github.com/
[clojure]: http://clojure.org/
[backlog-importer-usage]: https://github.com/bouzuya/clj-backlog-importer#usage

